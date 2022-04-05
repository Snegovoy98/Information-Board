import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Drawer {
    id: topDrawer
    edge: Qt.TopEdge
    width: parent.width
    height: parent.height * tenPercent

    readonly property double  tenPercent: 0.1

    readonly property double  thirtyPercent: 0.3

    ColumnLayout {
        id: mainPageColumn
        width: parent.width * tenPercent
        height: parent.height

        Image {
            id: mainPageLogo
            sourceSize.width: mainObject.controlButtonsSize
            sourceSize.height: mainObject.controlButtonsSize
            source: "../../resources/buttons_img/main_page.png"
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    settingsPage.visible = false
                    topDrawer.close()
                }
            }
        }

        Label {
            id: mainPageTitle
            text: "Main"
            font.family: mainObject.fontFamily
            font.pointSize: mainObject.sevenPoints
            Layout.alignment: Qt.AlignHCenter
        }
    }


    ColumnLayout {
        id: settingsColumn
        width: parent.width * tenPercent
        height: parent.height
        anchors.left: mainPageColumn.right

        Image {
            id: settingsLogo
            sourceSize.width: mainObject.controlButtonsSize
            sourceSize.height: mainObject.controlButtonsSize
            source: "../../resources/buttons_img/settings.png"
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                onClicked:  {
                    settingsPage.visible = true
                    topDrawer.close()
                }
            }
        }

        Label {
            id: settingsTitle
            text: "Settings"
            font.family: mainObject.fontFamily
            font.pointSize: mainObject.sevenPoints
            Layout.alignment: Qt.AlignHCenter
        }
    }
}

