import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Widgets
import src.singletons 1.0
import src.widgets 1.0

RowLayout {
    id: root

    spacing: 10

    Rectangle {
        id: musicPlayer

        Layout.preferredWidth: mainRow.implicitWidth + 30
        Layout.preferredHeight: 35
        Layout.alignment: Qt.AlignVCenter
        color: "#414868"
        radius: 6
        visible: Mpris.players.values.length > 0

        RowLayout {
            id: mainRow

            anchors.centerIn: parent
            spacing: 15

            RowLayout {
                spacing: 8

                Text {
                    id: musicText

                    maximumLineCount: 1
                    elide: Text.ElideRight
                    Layout.maximumWidth: 200
                    color: "#9ece6a"
                    text: "󰝚  " + (Mpris.players.values.length > 0 ? Mpris.players.values[0].trackTitle : "")
                    font.pixelSize: 14
                    font.family: "JetBrains Mono"
                }

            }

            VolumeWidget {
                id: volWidget

                Layout.preferredWidth: 35
                Layout.alignment: Qt.AlignVCenter
            }

        }

        Behavior on visible {
            NumberAnimation {
                duration: 200
            }

        }

    }

    Rectangle {
        id: clockWidget

        Layout.alignment: Qt.AlignVCenter
        Layout.preferredWidth: 100
        Layout.preferredHeight: 35
        color: clockMouse.containsMouse ? "#414868" : "transparent"
        radius: 6

        Text {
            anchors.centerIn: parent
            color: "#c0caf5"
            text: Time.time
            font.pixelSize: 14
            font.family: "JetBrains Mono"
        }

        WrapperMouseArea {
            id: clockMouse

            anchors.fill: parent
            hoverEnabled: true
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
            }

        }

    }

}
