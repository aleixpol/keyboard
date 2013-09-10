/*
 * Copyright 2013 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Window 2.0
import "languages/"

Item {
    id: panel

    property int keyWidth: 0
    property int keyHeight: 0

    property Item activeKeypad: characterKeypadLoader.item
    property var symbolKeypad

    state: "CHARACTERS"

    function loadLayout(layoutId)
    {
        if (layoutId === "number")
            characterKeypadLoader.source = "languages/Keyboard_numbers.qml"
        if (layoutId === "phonenumber")
            characterKeypadLoader.source = "languages/Keyboard_telephone.qml"
        if (layoutId === "email")
            characterKeypadLoader.source = "languages/Keyboard_en_email.qml"
        if (layoutId === "url")
            characterKeypadLoader.source = "languages/Keyboard_en_url_search.qml"
        if (layoutId === "en_us")
            characterKeypadLoader.source = "languages/Keyboard_en_us.qml"
    }

    Loader {
        id: characterKeypadLoader
        anchors.fill: parent

        source: "languages/Keyboard_en_us.qml"

        onLoaded: {
            activeKeypad = characterKeypadLoader.item
            symbolKeypad = characterKeypadLoader.item.symbols
        }

    }

    onSymbolKeypadChanged: {
        if (symbolKeypad != "")
            symbolKeypadLoader.source = symbolKeypad
        else
            state = "CHARACTERS"
    }

    Loader {
        id: symbolKeypadLoader
        anchors.fill: parent

        source: "languages/Keyboard_symbols.qml"
    }


    states: [
        State {
            name: "CHARACTERS"
            PropertyChanges {
                target: panel
                activeKeypad: characterKeypadLoader.item
            }
            PropertyChanges {
                target: characterKeypadLoader
                visible: true
            }
            PropertyChanges {
                target: symbolKeypadLoader
                visible: false
            }
        },
        State {
            name: "SYMBOLS"
            PropertyChanges {
                target: panel
                activeKeypad: symbolKeypadLoader
            }
            PropertyChanges {
                target: characterKeypadLoader
                visible: false
            }
            PropertyChanges {
                target: symbolKeypadLoader
                visible: true
            }
        }
    ]

}

