import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.13
import "../utils/helper.js" as Helper

Rectangle {
    id: root
    height: 68
    width: row.width + 30
    color: application.theme.bg
    radius: 60
    layer.enabled: true
    layer.effect: DropShadow {
        verticalOffset: 4
        horizontalOffset: 0
        color: "#33000000"
        radius: 20
        samples: 8
        spread: 0
    }

    MouseArea {
        // this is just to trap mouse event
        anchors.fill: parent
    }

    property string current: "Today"

    Row {
        id: row
        x: 15
        anchors.verticalCenter: parent.verticalCenter
        spacing: 9

        NavChip {
            state: current === label.text ? "" : "closed"
            label.text: "Today"
            icon: Helper.svg(
                      `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9.15722 20.7714V17.7047C9.1572 16.9246 9.79312 16.2908 10.581 16.2856H13.4671C14.2587 16.2856 14.9005 16.9209 14.9005 17.7047V17.7047V20.7809C14.9003 21.4432 15.4343 21.9845 16.103 22H18.0271C19.9451 22 21.5 20.4607 21.5 18.5618V18.5618V9.83784C21.4898 9.09083 21.1355 8.38935 20.538 7.93303L13.9577 2.6853C12.8049 1.77157 11.1662 1.77157 10.0134 2.6853L3.46203 7.94256C2.86226 8.39702 2.50739 9.09967 2.5 9.84736V18.5618C2.5 20.4607 4.05488 22 5.97291 22H7.89696C8.58235 22 9.13797 21.4499 9.13797 20.7714V20.7714" stroke="${label.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>`)
            onClicked: root.current = label.text
        }

        NavChip {
            state: current === label.text ? "" : "closed"
            label.text: "Saved"
            icon: Helper.svg(
                      `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M3.09264 9.40427H20.9166" stroke="${label.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M16.4421 13.3097H16.4513" stroke="${label.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M12.0046 13.3097H12.0139" stroke="${label.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M7.55789 13.3097H7.56716" stroke="${label.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M16.4421 17.1962H16.4513" stroke="${label.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M12.0046 17.1962H12.0139" stroke="${label.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M7.55789 17.1962H7.56716" stroke="${label.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M16.0437 2V5.29078" stroke="${label.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M7.96551 2V5.29078" stroke="${label.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path fill-rule="evenodd" clip-rule="evenodd" d="M16.2383 3.57919H7.77096C4.83427 3.57919 3 5.21513 3 8.22222V17.2719C3 20.3262 4.83427 22 7.77096 22H16.229C19.175 22 21 20.3546 21 17.3475V8.22222C21.0092 5.21513 19.1842 3.57919 16.2383 3.57919Z" stroke="${label.color}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>`)
            onClicked: root.current = label.text
        }
    }
}
