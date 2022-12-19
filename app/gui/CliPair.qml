import QtQuick 2.0
import QtQuick.Controls 2.2

import ComputerManager 1.0
import SdlGamepadKeyNavigation 1.0

Item {
    function onSearchingComputer() {
    }

    function onPairing(pcName, pin) {
    }

    function onFailed(message) {
        Qt.quit()
    }

    function onSuccess(appName) {
        Qt.quit()
    }

    // Allow user to back out of pairing
    Keys.onEscapePressed: {
        Qt.quit()
    }
    Keys.onBackPressed: {
        Qt.quit()
    }
    Keys.onCancelPressed: {
        Qt.quit()
    }

    StackView.onActivated: {
        if (!launcher.isExecuted()) {
            toolBar.visible = false

            // Normally this is enabled by PcView, but we will won't
            // load PcView when streaming from the command-line.
            SdlGamepadKeyNavigation.enable()

            launcher.searchingComputer.connect(onSearchingComputer)
            launcher.pairing.connect(onPairing)
            launcher.failed.connect(onFailed)
            launcher.success.connect(onSuccess)
            launcher.execute(ComputerManager)
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: 5
        id: stageIndicator

        BusyIndicator {
            id: stageSpinner
        }

        Label {
            id: stageLabel
            height: stageSpinner.height
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter

            wrapMode: Text.Wrap
        }
    }

    ErrorMessageDialog {
        id: errorDialog

        onClosed: {
            Qt.quit();
        }
    }
}
