import QtQuick
import QtQuick.Controls 2.15

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Inforamtion Board")


    BorderImage {
        id: borderImg
        source: "resources/background_images/Background.jpg"
        anchors.fill: parent
    }
}
