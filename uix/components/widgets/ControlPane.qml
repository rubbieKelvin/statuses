import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.9
import "../utils"
import "../utils/helper.js" as Helper

Item {
	id: root
	required property Video video
	property bool playing: true

	Component.onCompleted: {
		overlay.opacity = 1
		timer.restart()
	}

	MouseArea {
		anchors.fill: parent
		onClicked: {
			if (playing) {
				video.pause()
			} else {
				video.play()
			}

			overlay.opacity = 1
			timer.restart()
		}
	}

	Rectangle {
		id: overlay
		anchors.fill: parent
		color: "#55000000"

		Timer {
			id: timer
			interval: 1000
			repeat: false
			onTriggered: anim.start()
		}

		NumberAnimation {
			id: anim
			target: overlay
			property: "opacity"
			duration: 400
			from: 1
			to: 0
			easing.type: Easing.InOutQuad
		}

		Rectangle {
			id: more_btn_g
			width: 65
			height: 65
			radius: width / 2
			anchors.centerIn: parent
			color: "#44ffffff"

			RippleArea {
				anchors.fill: parent
				clipRadius: parent.radius
			}

			Image {
				id: btn_img
				readonly property string play_svg: '<svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M15 2.5C8.1 2.5 2.5 8.1 2.5 15C2.5 21.9 8.1 27.5 15 27.5C21.9 27.5 27.5 21.9 27.5 15C27.5 8.1 21.9 2.5 15 2.5ZM12.5 20.625L20 15L12.5 9.375V20.625ZM5 15C5 20.5125 9.4875 25 15 25C20.5125 25 25 20.5125 25 15C25 9.4875 20.5125 5 15 5C9.4875 5 5 9.4875 5 15Z" fill="#252525"/></svg>'
				readonly property string pause_svg: '<svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M2.5 15C2.5 8.1 8.1 2.5 15 2.5C21.9 2.5 27.5 8.1 27.5 15C27.5 21.9 21.9 27.5 15 27.5C8.1 27.5 2.5 21.9 2.5 15ZM13.75 20H11.25V10H13.75V20ZM15 25C9.4875 25 5 20.5125 5 15C5 9.4875 9.4875 5 15 5C20.5125 5 25 9.4875 25 15C25 20.5125 20.5125 25 15 25ZM18.75 20H16.25V10H18.75V20Z" fill="#252525"/></svg>'
				property string svg: play_svg
				anchors.centerIn: parent
				source: Helper.svg(svg)
			}

			Connections {
				target: video
				function onPlaying() {
					playing = true
					btn_img.svg = btn_img.pause_svg
				}

				function onPaused() {
					btn_img.svg = btn_img.play_svg
					playing = false
				}

				function onStopped() {
					playing = false
					btn_img.svg = btn_img.play_svg
				}
			}
		}
	}
}
