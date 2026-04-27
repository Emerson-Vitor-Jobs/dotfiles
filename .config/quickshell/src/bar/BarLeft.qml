import QtQuick
import QtQuick.Layouts
import src.widgets 1.0

RowLayout {
    Rectangle {
        Layout.alignment: Qt.AlignCenter
        implicitWidth: workspaces.implicitWidth + 13
        implicitHeight: 35
        color: "#414868"
        radius: 6

        WorkspacesWidget {
            id: workspaces

            anchors.centerIn: parent
        }

    }

}
