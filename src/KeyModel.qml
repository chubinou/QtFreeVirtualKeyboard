import QtQuick 2.0

/**
 * This is quick and dirty model for the keys of the InputPanel *
 * The code has been derived from
 * http://tolszak-dev.blogspot.de/2013/04/qplatforminputcontext-and-virtual.html
 * Copyright 2015 Uwe Kindler
 * Licensed under MIT see LICENSE.MIT in project root
 */
Item {
    property QtObject firstRowModel: first
    property QtObject secondRowModel: second
    property QtObject thirdRowModel: third


    ListModel {
        id:first
        ListElement { letter: "q"; firstSymbol: "1"; keycode: Qt.Key_Q; symbolKeycode: Qt.Key_1; keyIdOffset: 0}
        ListElement { letter: "w"; firstSymbol: "2"; keycode: Qt.Key_W; symbolKeycode: Qt.Key_2; keyIdOffset: 0}
        ListElement { letter: "e"; firstSymbol: "3"; keycode: Qt.Key_E; symbolKeycode: Qt.Key_3; keyIdOffset: 0}
        ListElement { letter: "r"; firstSymbol: "4"; keycode: Qt.Key_R; symbolKeycode: Qt.Key_4; keyIdOffset: 0}
        ListElement { letter: "t"; firstSymbol: "5"; keycode: Qt.Key_T; symbolKeycode: Qt.Key_5; keyIdOffset: 0}
        ListElement { letter: "y"; firstSymbol: "6"; keycode: Qt.Key_Y; symbolKeycode: Qt.Key_6; keyIdOffset: 0}
        ListElement { letter: "u"; firstSymbol: "7"; keycode: Qt.Key_U; symbolKeycode: Qt.Key_7; keyIdOffset: 0}
        ListElement { letter: "i"; firstSymbol: "8"; keycode: Qt.Key_I; symbolKeycode: Qt.Key_8; keyIdOffset: 0}
        ListElement { letter: "o"; firstSymbol: "9"; keycode: Qt.Key_O; symbolKeycode: Qt.Key_9; keyIdOffset: 0}
        ListElement { letter: "p"; firstSymbol: "0"; keycode: Qt.Key_E; symbolKeycode: Qt.Key_0; keyIdOffset: 0}
    }
    ListModel {
        id:second
        ListElement { letter: "a"; firstSymbol: "!"; keycode: Qt.Key_A; symbolKeycode: Qt.Key_Exclam; keyIdOffset: 10}
        ListElement { letter: "s"; firstSymbol: "@"; keycode: Qt.Key_S; symbolKeycode: Qt.Key_At; keyIdOffset: 10}
        ListElement { letter: "d"; firstSymbol: "#"; keycode: Qt.Key_D; symbolKeycode: Qt.Key_NumberSign; keyIdOffset: 10}
        ListElement { letter: "f"; firstSymbol: "$"; keycode: Qt.Key_F; symbolKeycode: Qt.Key_Dollar; keyIdOffset: 10}
        ListElement { letter: "g"; firstSymbol: "%"; keycode: Qt.Key_G; symbolKeycode: Qt.Key_Percent; keyIdOffset: 10}
        ListElement { letter: "h"; firstSymbol: "&"; keycode: Qt.Key_H; symbolKeycode: Qt.Key_Ampersand; keyIdOffset: 10}
        ListElement { letter: "j"; firstSymbol: "*"; keycode: Qt.Key_J; symbolKeycode: Qt.Key_Asterisk; keyIdOffset: 10}
        ListElement { letter: "k"; firstSymbol: "?"; keycode: Qt.Key_K; symbolKeycode: Qt.Key_Question; keyIdOffset: 10}
        ListElement { letter: "l"; firstSymbol: "/"; keycode: Qt.Key_L; symbolKeycode: Qt.Key_Slash; keyIdOffset: 10}
    }
    ListModel {
        id:third
        ListElement { letter: "z"; firstSymbol: "_"; keycode: Qt.Key_Z; symbolKeycode: Qt.Key_Underscore; keyIdOffset: 19}
        ListElement { letter: "x"; firstSymbol: "\""; keycode: Qt.Key_X; symbolKeycode: Qt.Key_QuoteDbl; keyIdOffset: 19}
        ListElement { letter: "c"; firstSymbol: "'"; keycode: Qt.Key_C; symbolKeycode: Qt.Key_Apostrophe; keyIdOffset: 19}
        ListElement { letter: "v"; firstSymbol: "("; keycode: Qt.Key_V; symbolKeycode: Qt.Key_ParenLeft; keyIdOffset: 19}
        ListElement { letter: "b"; firstSymbol: ")"; keycode: Qt.Key_B; symbolKeycode: Qt.Key_ParenRight; keyIdOffset: 19}
        ListElement { letter: "n"; firstSymbol: "-"; keycode: Qt.Key_N; symbolKeycode: Qt.Key_Minus; keyIdOffset: 19}
        ListElement { letter: "m"; firstSymbol: "+"; keycode: Qt.Key_M; symbolKeycode: Qt.Key_Plus; keyIdOffset: 19}
    }
}
