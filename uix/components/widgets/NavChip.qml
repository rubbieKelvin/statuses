import QtQuick 2.15
import QtQuick.Controls 2.15

import "../utils"
import "../utils/helper.js" as Helper

Rectangle {
    id: root
    height: 56
    radius: 30
    width: txt.x + txt.width + 15
    color: application.theme.accent

    signal clicked
    property alias label: txt
    property string icon: Helper.svg(
                              `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9.15722 20.7714V17.7047C9.1572 16.9246 9.79312 16.2908 10.581 16.2856H13.4671C14.2587 16.2856 14.9005 16.9209 14.9005 17.7047V17.7047V20.7809C14.9003 21.4432 15.4343 21.9845 16.103 22H18.0271C19.9451 22 21.5 20.4607 21.5 18.5618V18.5618V9.83784C21.4898 9.09083 21.1355 8.38935 20.538 7.93303L13.9577 2.6853C12.8049 1.77157 11.1662 1.77157 10.0134 2.6853L3.46203 7.94256C2.86226 8.39702 2.50739 9.09967 2.5 9.84736V18.5618C2.5 20.4607 4.05488 22 5.97291 22H7.89696C8.58235 22 9.13797 21.4499 9.13797 20.7714V20.7714" stroke="${txt.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>`)

    RippleArea {
        anchors.fill: parent
        clipRadius: parent.radius
        onClicked: root.clicked()
    }

    Image {
        id: img
        x: 15
        anchors.verticalCenter: parent.verticalCenter
        source: icon
    }

    Label {
        id: txt
        clip: true
        x: img.x + img.width + 10
        color: "#fff"
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 17
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Medium
    }

    states: [
        State {
            name: "closed"

            PropertyChanges {
                target: root
                width: img.x + img.width + 15
                color: application.theme.bg
            }

            PropertyChanges {
                target: txt
                visible: false
                width: 0
                color: application.theme.text
            }
        }
    ]
    transitions: [
        Transition {
            id: transition
            ParallelAnimation {
                SequentialAnimation {
                    PropertyAnimation {
                        target: root
                        property: "width"
                        duration: 120
                    }
                }
                PropertyAnimation {
                    target: txt
                    property: "width"
                    duration: 120
                }
            }
            to: "*"
            from: "*"
        }
    ]
}
