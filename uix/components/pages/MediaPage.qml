import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.15

import "../utils/helper.js" as Helper
import "../widgets"

Page {
    id: root
    background: Rectangle {
        color: application.theme.bg
    }

    property string source: ""
    property alias video: video
    readonly property string mediaType: Helper.mediaType(source)

    signal errorOccured
    signal clicked
    signal doubleTapped

    function loadSource(source) {
        root.source = source
        if (mediaType === "VIDEO") {
            video.source = source
            v_control.show()
        } else if (mediaType === "GIF") {
            gif.source = source
        } else if (mediaType === "IMAGE") {
            img.source = source
        }
    }

    Item {
        anchors.fill: parent

        Image {
            id: img
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            asynchronous: true
        }

        AnimatedImage {
            id: gif
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
            asynchronous: true
        }

        Video {
            id: video
            volume: 1.0
            anchors.fill: parent
            audioRole: MediaPlayer.VideoRole
            fillMode: VideoOutput.PreserveAspectFit

            Component.onCompleted: {
                v_control.hide()
            }

            onStatusChanged: {
                if (status === MediaPlayer.InvalidMedia) {
                    root.errorOccured()
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
        onDoubleClicked: root.doubleTapped()
    }

    VideoControl {
        id: v_control
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.margins: 10
        video: root.video
    }
}
