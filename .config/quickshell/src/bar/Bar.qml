import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

Scope {
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Variants {
        model: Quickshell.screens

        delegate: PanelWindow {
            id: panelWindow

            required property var modelData

            screen: modelData
            implicitHeight: 50
            color: "#1a1b26"

            anchors {
                top: true
                left: true
                right: true
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 0

                BarLeft {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                }

                Item {
                    Layout.fillWidth: true
                }

                BarCenter {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Item {
                    Layout.fillWidth: true
                }

                BarRight {
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                }

            }

        }

    }

}
