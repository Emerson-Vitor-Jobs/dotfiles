import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

RowLayout {
    id: root

    property var sink: Pipewire.defaultAudioSink
    property int volume: sink ? Math.round((sink.audio.volume ?? 0) * 100) : 0
    property bool isMuted: sink ? (sink.audio.muted ?? false) : true

    function getVolumeIcon() {
        if (root.isMuted || root.volume === 0)
            return "󰝟";

        if (root.volume < 30)
            return "󰕿";

        if (root.volume < 70)
            return "󰖀";

        return "󰕾"; // High
    }

    spacing: 5

    Text {
        color: "#bb9af7"
        text: root.getVolumeIcon() + " " + root.volume + "%"
        font.pixelSize: 14
        font.family: "JetBrains Mono"
    }

}
