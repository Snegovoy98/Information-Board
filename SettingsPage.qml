import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: settingsPage
    width: ApplicationWindow.width
    height: ApplicationWindow.height

    QtObject {
        id: settingsObject
        readonly property string fontFamily: "Decorative"
        readonly property int fontPointSize: 7
        readonly property int fontMenuPointSize: 10
        readonly property int buttonsSize: 25
        readonly property int menuButtonsSize: 40
        readonly property double tenPercent: 0.1
        readonly property double twentyPercent: 0.2
        readonly property double thirtyPercent: 0.3
        readonly property double sixtyPercent: 0.6
    }

    Rectangle {
        id: headerRect
        width: parent.width
        height: parent.height * settingsObject.tenPercent

        Image {
            id: hamburgerImg
            source: "resources/buttons_img/menu_btn.png"
            width: settingsObject.menuButtonsSize
            height: settingsObject.menuButtonsSize

            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                anchors.fill: parent
                onClicked: leftSideDrawer.open()
            }
        }
    }

    Drawer {
        id: leftSideDrawer
        width: parent.width * settingsObject.twentyPercent
        height: parent.height
        edge: Qt.LeftEdge

        Rectangle {
            id: homePageRect
            width: parent.width
            height: parent.height * settingsObject.tenPercent

            Image {
                id: returnToMainPageImg
                source: "resources/buttons_img/main_page.png"
                width: settingsObject.buttonsSize
                height: settingsObject.buttonsSize
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                id: homePageTitle
                text: "Главная"
                font.family: settingsObject.fontFamily
                font.pointSize: settingsObject.fontMenuPointSize
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: settingsPage.visible = false
            }
        }
    }

    Rectangle {
        id: networkSettingsRect
        width: parent.width * settingsObject.sixtyPercent
        height: parent.height * settingsObject.twentyPercent
        anchors.top: headerRect.bottom

        GroupBox {
            title: qsTr("Сетевые настройки")

            ColumnLayout {
                anchors.fill: parent

                RowLayout {
                    width: parent.width
                    height: parent.height

                    Label {
                        text: "Адрес подключения"
                        font.family: settingsObject.fontFamily
                        font.pointSize: settingsObject.fontPointSize
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Label {
                        text: "Порт подключения"
                        font.family: settingsObject.fontFamily
                        font.pointSize: settingsObject.fontPointSize
                        horizontalAlignment: Text.AlignRight
                    }
                }

                RowLayout {
                    width: parent.width
                    height: parent.height

                    TextField {
                        text: "127.0.0.1"
                        font.family: settingsObject.fontFamily
                        font.pointSize: settingsObject.fontPointSize
                        selectByMouse: true
                    }

                    TextField {
                        text: "7755"
                        font.family: settingsObject.fontFamily
                        font.pointSize: settingsObject.fontPointSize
                        selectByMouse: true
                    }
                }
            }
        }
    }
}
