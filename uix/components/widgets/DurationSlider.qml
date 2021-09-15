import QtQuick 2.15
import QtQuick.Controls 2.15

Slider {
    id: root

    property string color: "#000000"
    property string hintColor: "#bdbdbd"
    property string dotColor: "#ffffff"

    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 20
        width: root.availableWidth
        height: implicitHeight
        radius: 4
        color: root.hintColor
        clip: true

        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            color: root.color
            radius: 4
        }
    }

    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 26
        implicitHeight: 26
        radius: 4
        color: root.pressed ? root.dotColor : "#33ffffff"
    }
}
