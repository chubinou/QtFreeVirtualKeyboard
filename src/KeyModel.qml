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
        ListElement { letter: "a"; firstSymbol: "1"; keycode: Qt.Key_A; symbolKeycode: Qt.Key_1; }
        ListElement { letter: "z"; firstSymbol: "2"; keycode: Qt.Key_Z; symbolKeycode: Qt.Key_2; }
        ListElement { letter: "e"; firstSymbol: "3"; keycode: Qt.Key_E; symbolKeycode: Qt.Key_3; }
        ListElement { letter: "r"; firstSymbol: "4"; keycode: Qt.Key_R; symbolKeycode: Qt.Key_4; }
        ListElement { letter: "t"; firstSymbol: "5"; keycode: Qt.Key_T; symbolKeycode: Qt.Key_5; }
        ListElement { letter: "y"; firstSymbol: "6"; keycode: Qt.Key_Y; symbolKeycode: Qt.Key_6; }
        ListElement { letter: "u"; firstSymbol: "7"; keycode: Qt.Key_U; symbolKeycode: Qt.Key_7; }
        ListElement { letter: "i"; firstSymbol: "8"; keycode: Qt.Key_I; symbolKeycode: Qt.Key_8; }
        ListElement { letter: "o"; firstSymbol: "9"; keycode: Qt.Key_O; symbolKeycode: Qt.Key_9; }
        ListElement { letter: "p"; firstSymbol: "0"; keycode: Qt.Key_P; symbolKeycode: Qt.Key_0; }
    }
    ListModel {
        id:second
        ListElement { letter: "q"; firstSymbol: "!"; keycode: Qt.Key_Q; symbolKeycode: Qt.Key_Exclam; }
        ListElement { letter: "s"; firstSymbol: "="; keycode: Qt.Key_S; symbolKeycode: Qt.Key_Equal; }
        ListElement { letter: "d"; firstSymbol: "#"; keycode: Qt.Key_D; symbolKeycode: Qt.Key_NumberSign; }
        ListElement { letter: "f"; firstSymbol: "$"; keycode: Qt.Key_F; symbolKeycode: Qt.Key_Dollar; }
        ListElement { letter: "g"; firstSymbol: "%"; keycode: Qt.Key_G; symbolKeycode: Qt.Key_Percent; }
        ListElement { letter: "h"; firstSymbol: "&"; keycode: Qt.Key_H; symbolKeycode: Qt.Key_Ampersand; }
        ListElement { letter: "j"; firstSymbol: "*"; keycode: Qt.Key_J; symbolKeycode: Qt.Key_Asterisk; }
        ListElement { letter: "k"; firstSymbol: "?"; keycode: Qt.Key_K; symbolKeycode: Qt.Key_Question; }
        ListElement { letter: "l"; firstSymbol: "~"; keycode: Qt.Key_L; symbolKeycode: Qt.Key_AsciiTilde; }
        ListElement { letter: "m"; firstSymbol: "|"; keycode: Qt.Key_M; symbolKeycode: Qt.Key_Bar; }
    }
    ListModel {
        id:third
        ListElement { letter: "w"; firstSymbol: "_"; keycode: Qt.Key_W; symbolKeycode: Qt.Key_Underscore; }
        ListElement { letter: "x"; firstSymbol: "\""; keycode: Qt.Key_X; symbolKeycode: Qt.Key_QuoteDbl; }
        ListElement { letter: "c"; firstSymbol: "'"; keycode: Qt.Key_C; symbolKeycode: Qt.Key_Apostrophe; }
        ListElement { letter: "v"; firstSymbol: "("; keycode: Qt.Key_V; symbolKeycode: Qt.Key_ParenLeft; }
        ListElement { letter: "b"; firstSymbol: ")"; keycode: Qt.Key_B; symbolKeycode: Qt.Key_ParenRight; }
        ListElement { letter: "n"; firstSymbol: "["; keycode: Qt.Key_N; symbolKeycode: Qt.Key_BracketLeft; }
        ListElement { letter: "@"; firstSymbol: "]"; keycode: Qt.Key_At; symbolKeycode: Qt.Key_BracketRight; }
        ListElement { letter: "."; firstSymbol: ","; keycode: Qt.Key_Comma; symbolKeycode: Qt.Key_Colon; }
        ListElement { letter: ":"; firstSymbol: ";"; keycode: Qt.Key_Period; symbolKeycode: Qt.Key_Semicolon; }
        ListElement { letter: "/"; firstSymbol: "\\"; keycode: Qt.Key_Slash; symbolKeycode: Qt.Key_Backslash; }
    }
}
