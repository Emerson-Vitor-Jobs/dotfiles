import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import src.singletons 1.0

pragma ComponentBehavior: Bound
Row {
    spacing: 15

    Repeater {
        model: Hyprland.monitors

        delegate: Rectangle {
            id: monitorContainer

            required property var modelData
            property var currentMonitor: modelData

            width: workspacesRow.implicitWidth + 15
            height: 30
            color: "#24283b"
            radius: 8
            border.color: currentMonitor.name === FocusedMonitorStore.focusedMonitor ? "#7aa2f7" : "#444"
            border.width: 1

            Row {
                id: workspacesRow

                anchors.centerIn: parent
                spacing: 8

                Repeater {
                    model: Hyprland.workspaces

                    delegate: Rectangle {
                        id: workspaceRect

                        required property var modelData
                        readonly property bool isOnThisMonitor: modelData.monitor.name === monitorContainer.currentMonitor.name

                        Component.onCompleted: {
                            console.log("Workspace ID: " + modelData.id + " | Pertence ao monitor: " + monitorContainer.currentMonitor.name);
                        }
                        visible: isOnThisMonitor
                        implicitWidth: !isOnThisMonitor ? 0 : (modelData.active ? 30 : 15)
                        implicitHeight: 15
                        radius: 5
                        color: modelData.active ? "#7aa2f7" : "#24283b"

                        Text {
                            anchors.centerIn: parent
                            text: workspaceRect.modelData.id
                            color: !workspaceRect.modelData.active ? "#7aa2f7" : "#24283b"
                            font.bold: true
                            visible: parent.visible
                        }

                        WrapperMouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if (!workspaceRect.modelData.active)
                                    Hyprland.dispatch(`workspace ${workspaceRect.modelData.id}`);

                            }
                        }

                        Behavior on implicitWidth {
                            NumberAnimation {
                                duration: 300
                                easing.type: Easing.InOutBack
                            }

                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 300
                            }

                        }

                    }

                }

            }

        }

    }

}

