import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.15
import "../utils/helper.js" as Helper

Item {
    id: root
    height: body.height + 30

    readonly property int max_w: Math.min(application.width,
                                          application.height) - 50

    property Video video

    function show() {
        dur.text = Qt.binding(function () {
            return Helper.timeFromDuration(
                        video.position) + "/" + Helper.timeFromDuration(
                        video.duration)
        })
        root.visible = true
    }
    function hide() {
        dur.text = "00:00/00:00"
        root.visible = false
    }

    Rectangle {
        id: body
        width: row.width + 30
        height: row.height + 30
        clip: true
        radius: 10
        color: "#33ffffff"
        anchors.horizontalCenter: parent.horizontalCenter

        Row {
            id: row
            spacing: 5
            anchors.centerIn: parent

            DurationSlider {
                id: slider
                to: 100
                width: max_w * .72
                value: video ? (video.position / video.duration) * this.to : 0
                color: "#ffffff"
                dotColor: application.theme.accent
                stepSize: 0.1
                from: 0
                hintColor: "#55ffffff"
                onMoved: {
                    video.seek((this.value / this.to) * video.duration)
                }
            }

            Label {
                id: dur
                width: max_w * .28
                height: parent.height
                text: "00:00"
                font.pixelSize: 16
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                color: "#fff"
                font.weight: Font.Medium
            }
        }
    }
}
