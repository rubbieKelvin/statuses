import QtQuick 2.15
import QtQuick.Controls 2.15
import StuffsByRubbie 0.1

import "./components/utils"

ApplicationWindow {
    id: application
    width: 360
    height: 700
    visible: true
    font.family: montserrat.name
    flags: Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint
    property Theme theme: Theme {}
    property string currentSource: ""

    StatusBar {
        id: statusbar
        color: application.theme.bg
        theme: StatusBar.Dark
    }

    background: Rectangle {
        color: "white"
    }

    FontLoader {
        id: montserrat
        source: "./fonts/Montserrat/Montserrat-Regular.ttf"
    }

    StackView {
        id: mainstack
        anchors.fill: parent
        initialItem: "./components/pages/home.qml"
    }

    Connections {
        target: application
        function onClosing(event) {
            if (mainstack.depth > 1) {
                mainstack.pop()
                event.accepted = false
            } else {
                event.accepted = true
            }
        }
    }
}
