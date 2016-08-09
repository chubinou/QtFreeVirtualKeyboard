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
            repeat: true
            keyId: keyIdOffset + index
        }
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
    }

    /** Signal when a key has been activated by direct user action. */
    signal keyActivated(int keyId)
    Component.onCompleted: {
        keyPopup.visibleChanged.connect(function() {
            if (keyPopup.visible)
                keyActivated(keyPopup.keyId)
            else
                keyActivated(-1)
        })
    }

    /** Programatically highlight a key, as if it was pressed by the user. */
    property int activeKeyId: -1
    property var previousItem: undefined
    onActiveKeyIdChanged: {
        if (previousItem !== undefined)
            previousItem.isHighlighted = false

        if (activeKeyId < 0) {
            keyPopup.visible = false
            previousItem = undefined
        }
        else {
            var item = getKeyItem(activeKeyId)
            showKeyPopup(item)
            item.isHighlighted = true
            previousItem = item
            keyPopup.visible = true
        }
    }

    /**
     * Get the KeyButton corresponding to a given keyId.
     */
    function getKeyItem(id) {
        if (id < firstRow.count)
            return firstRow.itemAt(id);
        else if (id < firstRow.count + secondRow.count)
            return secondRow.itemAt(id - firstRow.count)
        else if (id < firstRow.count + secondRow.count + thirdRow.count)
            return thirdRow.itemAt(id - firstRow.count - secondRow.count)
        else {
            switch (id - (firstRow.count + secondRow.count + thirdRow.count)) {
            case 0:
                return shiftKey
            case 1:
                return backspaceKey
            case 2:
                return hideKey
            case 3:
                return emptyKey
            case 4:
                return commaKey
            case 5:
                return spacebarKey
            case 6:
                return dotKey
            case 7:
                return enterKey
            default:
                return undefined
            }
        }
    }

    /**
     * This function shows the character preview popup for each key button
     */
    function showKeyPopup(keyButton)
    {
        //console.log("showKeyPopup");
        keyPopup.popup(keyButton, root);
    }

    /**
     * The key popup for character preview
     */
    KeyPopup {
        id: keyPopup
        visible: false
        z: 100
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
                height: pimpl.rowHeight
                spacing: pimpl.horizontalSpacing
                anchors.horizontalCenter:parent.horizontalCenter
                Repeater {
                    id: firstRow
                    model: keyModel.firstRowModel
                    delegate: keyButtonDelegate
                }
            }
            Row {
                height: pimpl.rowHeight
                spacing: pimpl.horizontalSpacing
                anchors.horizontalCenter:parent.horizontalCenter
                Repeater {
                    id: secondRow
                    model: keyModel.secondRowModel
                    delegate: keyButtonDelegate
                }
            }
            Item {
                height: pimpl.rowHeight
                width:parent.width
                KeyButton {
                    id: shiftKey
                    color: (pimpl.shiftModifier)? "#1e6fa7": "#1e1b18"
                    anchors.left: parent.left
                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    font.family: "FontAwesome"
                    key: Qt.Key_Shift
                    text: "\uf062"
                    functionKey: true
                    keyId: firstRow.count + secondRow.count + thirdRow.count + 0
                    onClicked: {
                        if (pimpl.symbolModifier) {
                            pimpl.symbolModifier = false
                        }
                        pimpl.shiftModifier = !pimpl.shiftModifier
                    }
                    inputPanel: root
                }
                Row {
                    height: pimpl.rowHeight
                    spacing: pimpl.horizontalSpacing
                    anchors.horizontalCenter:parent.horizontalCenter
                    Repeater {
                        id: thirdRow
                        anchors.horizontalCenter: parent.horizontalCenter
                        model: keyModel.thirdRowModel
                        delegate: keyButtonDelegate
                    }
                }
                KeyButton {
                    id: backspaceKey
                    font.family: "FontAwesome"
                    color: "#1e1b18"
                    anchors.right: parent.right
                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: "\x7F"
                    key: Qt.Key_Backspace
                    displayText: "\uf177"
                    inputPanel: root
                    repeat: true
                    keyId: firstRow.count + secondRow.count + thirdRow.count + 1
                }
            }
            Row {
                height: pimpl.rowHeight
                spacing: pimpl.horizontalSpacing
                anchors.horizontalCenter:parent.horizontalCenter
                KeyButton {
                    id: hideKey
                    color: "#1e1b18"
                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    font.family: "FontAwesome"
                    text: "\uf078"
                    functionKey: true
                    onClicked: {
                        Qt.inputMethod.hide()
                        root.hideKeyPressed()
                    }
                    inputPanel: root
                    showPreview: false
                    keyId: firstRow.count + secondRow.count + thirdRow.count + 2
                }
                KeyButton {
                    id: emptyKey
                    color: "#1e1b18"
                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: ""
                    inputPanel: root
                    functionKey: true
                    keyId: firstRow.count + secondRow.count + thirdRow.count + 3
                }
                KeyButton {
                    id: commaKey
                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    key: Qt.Key_Comma
                    text: ","
                    inputPanel: root
                    keyId: firstRow.count + secondRow.count + thirdRow.count + 4
                }
                KeyButton {
                    id: spacebarKey
                    width: 3*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    key: Qt.Key_Space
                    text: " "
                    inputPanel: root
                    keyId: firstRow.count + secondRow.count + thirdRow.count + 5
                }
                KeyButton {
                    id: dotKey
                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    key: Qt.Key_Period
                    text: "."
                    inputPanel: root
                    keyId: firstRow.count + secondRow.count + thirdRow.count + 6
                }
                KeyButton {
                    id: symbolKey
                    color: "#1e1b18"
                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: (!pimpl.symbolModifier)? "12#" : "ABC"
                    functionKey: true
                    onClicked: {
                        if (pimpl.shiftModifier) {
                            pimpl.shiftModifier = false
                        }
                        pimpl.symbolModifier = !pimpl.symbolModifier
                    }
                    inputPanel: root
                }
                KeyButton {
                    id: enterKey
                    color: "#1e1b18"
                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    key: Qt.Key_Enter
                    displayText: "Enter"
                    text: "\n"
                    inputPanel: root
                    keyId: firstRow.count + secondRow.count + thirdRow.count + 7
                }
            }
        }
    }
}
