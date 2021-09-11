import QtQuick 2.15
import QtQuick.Controls 2.15

import "../utils"
import "../widgets"
import "../utils/helper.js" as Helper

Page {
    id: root
    header: Rectangle {
        id: rectangle
        color: "transparent"
        height: 70

        Row {
            id: row
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 20
            anchors.leftMargin: 20

            Label {
                width: parent.width
                text: "Statuses"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 28
                font.weight: Font.Bold
                color: application.theme.text
            }
        }
    }
    background: Rectangle {
        color: application.theme.bg
    }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: "./today.qml"
    }

    NavBar {
        id: nav
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 22
        anchors.horizontalCenter: parent.horizontalCenter

        onCurrentChanged: {
            if (stack.depth > 1)
                stack.pop()

            if (current == "Today")
                stack.push("./today.qml")
            else if (current == "Saved")
                stack.push("./saved.qml")
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:8}
}
##^##*/

