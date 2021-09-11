import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.9
import QtGraphicalEffects 1.13

import "../utils"
import "../utils/helper.js" as Helper

Rectangle {
    id: root
    clip: true
    radius: 10
    height: {
        const norm = width * .75
        if (mediaType == "VIDEO" || mediaType == "GIF") {
            return norm
        } else if (mediaType == "IMAGE") {
            return Math.max(norm, Math.min(img.sourceSize.height * .75, 500))
        }
    }
    color: (theme || {
                "accent": "red"
            }).accent
    width: 300

    signal clicked
    signal requestRemoval

    property string source
    readonly property string mediaType: {
        if (root.source.endsWith(".gif")) {
            return "GIF"
        } else if (root.source.endsWith(".mp4")) {
            return "VIDEO"
        } else {
            return "IMAGE"
        }
    }

    Item {
        id: media_body
        anchors.fill: parent
        property int radius: parent.radius

        RoundImage {
            id: img
            anchors.fill: parent
            radius: parent.radius
            fillMode: Image.PreserveAspectCrop
            enabled: visible
            visible: false

            Component.onCompleted: {
                if (mediaType == "IMAGE") {
                    this.source = root.source
                    visible = true
                }
            }
        }

        Video {
            id: video
            enabled: visible
            visible: false
            anchors.fill: parent
            loops: MediaPlayer.Infinite
            muted: true
            fillMode: VideoOutput.PreserveAspectCrop
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: video.width
                    height: video.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: video.width
                        height: video.height
                        radius: root.radius
                    }
                }
            }

            Component.onCompleted: {
                if (mediaType == "VIDEO") {
                    this.source = root.source
                    visible = true
                    play()
                }
            }
        }

        AnimatedImage {
            id: gimg
            anchors.fill: parent
            visible: false
            enabled: visible
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: gimg.width
                    height: gimg.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: gimg.width
                        height: gimg.height
                        radius: root.radius
                    }
                }
            }

            Component.onCompleted: {
                if (mediaType == "GIF") {
                    this.source = root.source
                    visible = true
                }
            }
        }
    }

    MouseArea {
        id: m
        anchors.fill: parent
        property bool down: false
        onClicked: root.clicked()
        onPressed: down = true
        onPressAndHold: {

        }

        onReleased: down = false
    }

    ItemMenu {
        width: parent.width - 20
        x: 10
        height: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        source: root.source
        onDeleted: root.requestRemoval(source)
    }
}

/*##^##
Designer {
    D{i:0;height:90}
}
##^##*/

