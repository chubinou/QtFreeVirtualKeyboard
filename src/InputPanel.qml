import QtQuick 2.0
import "."
import VirtualKeyboard 1.0

/**
 * This is the QML input panel that provides the virtual keyboard UI
 * The code has been derived from
 * http://tolszak-dev.blogspot.de/2013/04/qplatforminputcontext-and-virtual.html
 * Copyright 2015 Uwe Kindler
 * Licensed under MIT see LICENSE.MIT in project root
 */
Item {
    id:root
    objectName: "inputPanel"
    width: parent.width
    height: width / 4
    // Report actual keyboard rectangle to input engine
    onYChanged: InputEngine.setKeyboardRectangle(Qt.rect(x, y, width, height))

    signal hideKeyPressed()
    signal keyPressed(var key, int modifiers, string text)
    signal keyReleased(var key, int modifiers, string text)

    function sendKeyPress(key, text) {
        keyPressed(key, pimpl.shiftModifier ? Qt.ShiftModifier : Qt.NoModifier, text)
    }
    function sendKeyRelease(key, text) {
        keyReleased(key, pimpl.shiftModifier ? Qt.ShiftModifier : Qt.NoModifier, text)
    }

    property alias shiftActive: pimpl.shiftModifier
    property alias symbolsActive: pimpl.symbolModifier

    KeyModel {
        id:keyModel
    }

    FontLoader {
        source: "FontAwesome.otf"
    }

    QtObject {
        id:pimpl
        property bool shiftModifier: false
        property bool symbolModifier: false
        property int verticalSpacing: keyboard.height / 40
        property int horizontalSpacing: verticalSpacing
        property int rowHeight: keyboard.height/4 - verticalSpacing
        property int buttonWidth:  (keyboard.width-column.anchors.margins)/10 - horizontalSpacing

        property int focusRow: 0
        property int focusCol: 0
    }

    /**
     * The delegate that paints the key buttons
     */
    Component {
        id: keyButtonDelegate
        KeyButton {
            id: button
            width: pimpl.buttonWidth
            height: pimpl.rowHeight
            text: (pimpl.shiftModifier) ? letter.toUpperCase() : (pimpl.symbolModifier)?firstSymbol : letter
            key: (pimpl.symbolModifier) ? symbolKeycode : keycode
            inputPanel: root
            highlighted: pimpl.focusRow == button.row && pimpl.focusCol == button.col
        }
    }


    function translateCol( oldRow, oldCol, newRow )
    {
        var oldRowChildren = column.children[oldRow].children
        var newRowChildren = column.children[newRow].children
        var oldIndex = 0
        for (var i = 0; i <= oldCol; i++) {
            oldIndex += oldRowChildren[i].span
        }

        var newIndex = 0
        var newCol = 0
        for (var i = 0; i <= newRowChildren.length - 1; i++) {
            newIndex += newRowChildren[i].span
            if (newIndex >= oldIndex)
                return newCol
            newCol +=  1
        }
        return newCol - 1;
    }

    Connections {
        target: InputEngine
        // Switch the keyboard layout to Numeric if the input mode of the InputEngine changes
        onInputModeChanged: {
            pimpl.symbolModifier = ((InputEngine.inputMode == InputEngine.Numeric)
                                 || (InputEngine.inputMode == InputEngine.Dialable))
            if (pimpl.symbolModifier) {
                pimpl.shiftModifier = false
            }
        }
        onNavPressed: {
            if (key === Qt.Key_Right) {
                var colCount = column.children[pimpl.focusRow].children.length -1 //substract 1 for the repeater
                pimpl.focusCol = Math.min(pimpl.focusCol + 1, colCount - 1)
            } else if (key === Qt.Key_Left) {
                pimpl.focusCol = Math.max(pimpl.focusCol - 1, 0)
            } else if (key === Qt.Key_Up) {
                var rowCount = column.children.length
                var newRow = Math.max(pimpl.focusRow - 1, 0)

                pimpl.focusCol = translateCol( pimpl.focusRow, pimpl.focusCol, newRow )
                pimpl.focusRow = newRow
            } else if (key === Qt.Key_Down) {
                var rowCount = column.children.length
                var newRow = Math.min(pimpl.focusRow + 1, rowCount - 1)

                pimpl.focusCol = translateCol( pimpl.focusRow, pimpl.focusCol, newRow )
                pimpl.focusRow = newRow
            } else if (key === Qt.Key_Space) {
                column.children[pimpl.focusRow].children[pimpl.focusCol].pressed()
            }
        }
        onNavReleased: {
            if (key === Qt.Key_Space) {
                column.children[pimpl.focusRow].children[pimpl.focusCol].released()
            }
        }
    }
    
    Rectangle {
        id:keyboard
        color: "black"
        anchors.fill: parent;
        MouseArea {
            anchors.fill: parent
        }

        Column {
            id:column
            anchors.margins: 5
            anchors.fill: parent
            spacing: pimpl.verticalSpacing

            Row {
                id: firstRow
                height: pimpl.rowHeight
                spacing: pimpl.horizontalSpacing
                anchors.horizontalCenter:parent.horizontalCenter
                Repeater {
                    visible: false
                    model: keyModel.firstRowModel
                    delegate: keyButtonDelegate
                    onItemAdded: {
                        item.row = 0
                        item.col = index
                    }
                }
            }

            Row {
                id: secondRow
                height: pimpl.rowHeight
                spacing: pimpl.horizontalSpacing
                anchors.horizontalCenter:parent.horizontalCenter
                Repeater {
                    model: keyModel.secondRowModel
                    delegate: keyButtonDelegate
                    onItemAdded: {
                        item.row = 1
                        item.col = index
                    }
                }
            }

            Row {
                id: thirdRow
                height: pimpl.rowHeight
                spacing: pimpl.horizontalSpacing
                anchors.horizontalCenter:parent.horizontalCenter
                Repeater {
                    model: keyModel.thirdRowModel
                    delegate: keyButtonDelegate
                    onItemAdded: {
                        item.row = 2
                        item.col = index
                    }
                }
            }


            Row {
                id: lastRow
                height: pimpl.rowHeight
                spacing: pimpl.horizontalSpacing
                anchors.horizontalCenter:parent.horizontalCenter

                KeyButton {
                    id: shiftKey
                    alt: true
                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    font.family: "FontAwesome"
                    key: Qt.Key_Shift
                    text: "\uf062"
                    functionKey: true
                    highlighted: pimpl.focusRow == 3 && pimpl.focusCol == 0
                    onDoFunc: {
                        if (pimpl.symbolModifier) {
                            pimpl.symbolModifier = false
                        }
                        pimpl.shiftModifier = !pimpl.shiftModifier
                    }
                    inputPanel: root
                    KeyNavigation.right: hideKey
                }


                KeyButton {
                    id: hideKey
                    alt: true
                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    font.family: "FontAwesome"
                    text: "\uf078"
                    functionKey: true
                    highlighted: pimpl.focusRow == 3 && pimpl.focusCol == 1
                    onDoFunc: {
                        Qt.inputMethod.hide()
                        root.hideKeyPressed()
                    }
                    inputPanel: root
                    showPreview: false

                    KeyNavigation.right: symbolKey
                }

                KeyButton {
                    id: symbolKey
                    alt: true
                    span: 2
                    width: span *pimpl.buttonWidth + (span -1)* pimpl.horizontalSpacing
                    height: pimpl.rowHeight
                    text: (!pimpl.symbolModifier)? "12#" : "ABC"
                    functionKey: true
                    highlighted: pimpl.focusRow == 3 && pimpl.focusCol == 2
                    onDoFunc: {
                        if (pimpl.shiftModifier) {
                            pimpl.shiftModifier = false
                        }
                        pimpl.symbolModifier = !pimpl.symbolModifier
                    }
                    inputPanel: root
                    KeyNavigation.right: spacebarKey
                }

                KeyButton {
                    id: spacebarKey
                    span: 3
                    width: span *pimpl.buttonWidth + (span -1)* pimpl.horizontalSpacing
                    height: pimpl.rowHeight
                    key: Qt.Key_Space
                    text: " "
                    inputPanel: root
                    highlighted: pimpl.focusRow == 3 && pimpl.focusCol == 3

                    KeyNavigation.right: backspaceKey
                }


                KeyButton {
                    id: backspaceKey
                    font.family: "FontAwesome"
                    alt: true
                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: "\x7F"
                    key: Qt.Key_Backspace
                    displayText: "\uf177"
                    inputPanel: root
                    repeat: true
                    highlighted: pimpl.focusRow == 3 && pimpl.focusCol == 4
                    KeyNavigation.right: enterKey
                }


                KeyButton {
                    id: enterKey
                    alt: true
                    span: 2
                    width: span *pimpl.buttonWidth + (span -1)* pimpl.horizontalSpacing
                    height: pimpl.rowHeight
                    key: Qt.Key_Enter
                    displayText: "Enter"
                    text: "\n"
                    inputPanel: root
                    highlighted: pimpl.focusRow == 3 && pimpl.focusCol == 5
                }
                Item {}
            }
        }
    }
}
