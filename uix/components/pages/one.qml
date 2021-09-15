import QtQuick 2.15
import StuffsByRubbie 0.1
import QtQuick.Controls 2.15
import QtMultimedia 5.15

import "../utils"
import "../widgets"
import "../utils/helper.js" as Helper

Page {
    id: root
    background: Rectangle {
        color: application.theme.bg
    }

    property variant model
    property string current

    SwipeView {
        id: swipe
        anchors.fill: parent
        orientation: Qt.Vertical
        Component.onCompleted: currentIndex = root.model.indexOf(root.current)

        Repeater {
            model: root.model

            MediaPage {
                id: media_page

                function checkNearby() {
                    const i = swipe.currentIndex
                    const isPrev = i === 0 ? false : swipe.itemAt(
                                                 i - 1) === media_page
                    const isCurrent = swipe.itemAt(i) === media_page
                    const isNext = i === swipe.count - 1 ? false : swipe.itemAt(
                                                               i + 1) === media_page

                    if ((isPrev || isCurrent || isNext)
                            && media_page.source == "") {
                        media_page.loadSource(modelData)
                    }

                    if (Helper.mediaType(modelData) === "VIDEO") {
                        if (isCurrent) {
                            media_page.video.play()
                        } else {
                            media_page.video.stop()
                        }
                    }
                }

                Label {
                    id: llabel
                    text: ""
                    anchors.centerIn: parent
                    color: "white"
                    font.weight: Font.Bold
                    font.pixelSize: 18
                    opacity: 0
                    visible: opacity > 0
                    background: Rectangle {
                        color: "#33000000"
                        radius: 5
                        anchors.fill: parent
                        anchors.margins: -4
                    }

                    NumberAnimation {
                        id: lanim
                        target: llabel
                        property: "opacity"
                        duration: 800
                        from: llabel.opacity
                        to: 0
                        easing.type: Easing.InOutQuad
                    }

                    Timer {
                        id: ltimer
                        interval: 200
                        onTriggered: lanim.start()
                    }
                }

                Component.onCompleted: media_page.checkNearby()

                onErrorOccured: swipe.incrementCurrentIndex()
                onDoubleTapped: {
                    if (whatsapp.isSaved(modelData)) {
                        whatsapp.deleteStatus(modelData)
                        llabel.text = "Deleted status"
                    } else {
                        whatsapp.saveStatus(modelData)
                        llabel.text = "Saved Status"
                    }

                    llabel.opacity = 1
                    ltimer.restart()
                }

                onClicked: {

                    //                    if (Helper.mediaType(modelData) === "VIDEO") {
                    //                        if (media_page.video.playbackState == MediaPlayer.PlayingState) {
                    //                            media_page.video.pause()
                    //                            llabel.text = "Paused"
                    //                        } else if (media_page.video.playbackState == MediaPlayer.PausedState
                    //                                   || media_page.video.playbackState == MediaPlayer.StoppedState) {
                    //                            media_page.video.play()
                    //                            llabel.text = "Played"
                    //                        }
                    //                        llabel.opacity = 1
                    //                        ltimer.restart()
                    //                    }
                }

                Connections {
                    target: swipe

                    function onCurrentItemChanged() {
                        media_page.checkNearby()
                    }
                }

                Connections {
                    target: media_page.video

                    function onStatusChanged() {
                        if (media_page.video.status === MediaPlayer.EndOfMedia) {
                            if (swipe.currentIndex == swipe.count - 1) {
                                mainstack.pop()
                            } else {
                                swipe.incrementCurrentIndex()
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        height: 60
        width: parent.width
        color: "#00000000"

        Row {
            anchors.fill: parent
            anchors.margins: 8

            Button {
                height: 40
                width: 40
                background: Rectangle {
                    color: "#66ffffff"
                    radius: 20
                }
                icon.source: Helper.svg(
                                 `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                 <path d="M20 11L7.83 11L11.41 7.41L10 6L4 12L10 18L11.41 16.59L7.83 13L20 13V11Z" fill="white"/>
                                 </svg>
                                 `)

                RippleArea {
                    anchors.fill: parent
                    clipRadius: 20
                    onClicked: parent.clicked()
                }

                onClicked: {
                    mainstack.pop()
                }
            }
        }
    }
}
