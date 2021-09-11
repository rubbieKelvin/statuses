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

    SwipeView {}
}
