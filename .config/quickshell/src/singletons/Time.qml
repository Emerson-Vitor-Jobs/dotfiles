import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    // property string focusedMonitor: ""
    // readonly property string time: {
    //     Qt.formatDateTime(clock.date, "hh:mm:ss");
    // }
    // Socket {
    //     path: Quickshell.env("XDG_RUNTIME_DIR") + "/hypr/" + Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE") + "/.socket2.sock"
    //     connected: true
    //     parser: SplitParser {
    //         property var regex: new RegExp("focusedmon>>(.+),.*")
    //         onRead: (msg) => {
    //             const match = regex.exec(msg);
    //             if (match)
    //                 root.focusedMonitor = match[1];
    //         }
    //     }
    // }

    id: root

    readonly property string time: Qt.formatDateTime(clock.date, "hh:mm:ss")

    SystemClock {
        id: clock

        precision: SystemClock.Seconds
    }

}
