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
            width: mainObject.controlButtonsSize
            height: mainObject.controlButtonsSize
            source: "../../resources/buttons_img/main_page.png"
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                onClicked: settingsPage.visible = false
            }
        }

        Label {
            id: mainPageTitle
            text: "Главная"
            font.family: mainObject.fontFamily
            font.pointSize: mainObject.menuElemsPointSize
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
            width: mainObject.controlButtonsSize
            height: mainObject.controlButtonsSize
            source: "../../resources/buttons_img/settings.png"
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                onClicked:  {
                    settingsPage.visible = true
                }
            }
        }

        Label {
            id: settingsTitle
            text: "Настройки"
            font.family: mainObject.fontFamily
            font.pointSize: mainObject.menuElemsPointSize
            Layout.alignment: Qt.AlignHCenter
        }
    }
}

