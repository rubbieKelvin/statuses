import QtQuick 2.15
import QtQuick.Controls 2.15

import "../utils"
import "../widgets"
import "../utils/helper.js" as Helper

Page {
    id: root
    background: Rectangle {
        color: application.theme.bg
    }

    ScrollView {
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.fill: parent
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        ListView {
            id: listView
            clip: true
            spacing: 12
            anchors.fill: parent
            delegate: Card {
                source: filename
                width: (parent || {
                            "width": 0
                        }).width
                onClicked: {
                    application.currentSource = filename
                    mainstack.push('./one.qml', {
                                       "model": whatsapp.getSavedStatuses(),
                                       "current": filename
                                   })
                }
                onRequestRemoval: {
                    status_model.remove(index)
                }
            }

            model: ListModel {
                id: status_model

                Component.onCompleted: {
                    const data = {
                        "list": whatsapp.getSavedStatuses(),
                        "model": status_model
                    }

                    model_worker.sendMessage(data)
                }
            }

            footer: Rectangle {
                color: "transparent"
                height: 10
            }
        }

        WorkerScript {
            id: model_worker
            source: "../../workers/foldermodel.mjs"
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:8}
}
##^##*/

