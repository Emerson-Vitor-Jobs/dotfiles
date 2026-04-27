import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property string focusedMonitor: ""

    Socket {
        path: Quickshell.env("XDG_RUNTIME_DIR") + "/hypr/" + Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE") + "/.socket2.sock"
        connected: true

        parser: SplitParser {
            property var regex: new RegExp("focusedmon>>(.+),.*")

            onRead: (msg) => {
                const match = regex.exec(msg);
                if (match)
                    root.focusedMonitor = match[1];

            }
        }

    }

}
