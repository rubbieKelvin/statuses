import QtQuick 2.15
import QtQuick.Controls 2.15

import "../utils/"
import "../utils/helper.js" as Helper

Rectangle {
    id: root
    color: "transparent"
    clip: true
    property string source: ""

    signal saved(string source)
    signal deleted(string source)

    Button {
        id: more
        width: 40
        height: 40
        focusPolicy: Qt.StrongFocus
        background: Rectangle {
            color: "#33ffffff"
            radius: 20
        }

        icon.source: Helper.svg(
                         '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M11.8896 12.9451C12.4419 12.9451 12.8896 12.4974 12.8896 11.9451C12.8896 11.3928 12.4419 10.9451 11.8896 10.9451C11.3374 10.9451 10.8896 11.3928 10.8896 11.9451C10.8896 12.4974 11.3374 12.9451 11.8896 12.9451Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M18.8896 12.9451C19.4419 12.9451 19.8896 12.4974 19.8896 11.9451C19.8896 11.3928 19.4419 10.9451 18.8896 10.9451C18.3374 10.9451 17.8896 11.3928 17.8896 11.9451C17.8896 12.4974 18.3374 12.9451 18.8896 12.9451Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M4.88965 12.9451C5.44193 12.9451 5.88965 12.4974 5.88965 11.9451C5.88965 11.3928 5.44193 10.9451 4.88965 10.9451C4.33736 10.9451 3.88965 11.3928 3.88965 11.9451C3.88965 12.4974 4.33736 12.9451 4.88965 12.9451Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>')
        onClicked: {
            popup.open()
            visible = false
        }
    }

    Popup {
        id: popup
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        padding: 0
        clip: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        property bool saved: false

        Component.onCompleted: saved = whatsapp.isSaved(source)

        background: Rectangle {
            color: "transparent"
            radius: height / 2
        }

        enter: Transition {
            NumberAnimation {
                property: "width"
                from: 0
                to: root.width
                duration: 60
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "width"
                from: popup.width
                to: 0
                duration: 100
            }
        }

        onClosed: {
            more.visible = true
            saved = whatsapp.isSaved(source)
        }

        Row {
            id: ro
            anchors.fill: parent
            spacing: 10

            Repeater {
                model: ListModel {
                    id: modl

                    ListElement {
                        menutext: "Save"
                        menucolor: "#695EE7"
                    }

                    ListElement {
                        menutext: "Delete"
                        menucolor: "red"
                    }
                }

                NavChip {
                    width: ro.width
                    height: parent.height
                    label.text: menutext
                    color: menucolor
                    visible: (label.text == "Save") ? !popup.saved : popup.saved
                    icon: ""
                    label.width: width
                    label.x: 0

                    onClicked: {
                        if (label.text === "Save")
                            whatsapp.saveStatus(source)
                        else if (label.text === "Delete") {
                            whatsapp.deleteStatus(source)
                            deleted(source)
                        }
                        popup.close()
                    }
                }
            }
        }
    }
}
