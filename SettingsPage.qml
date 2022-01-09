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
        readonly property int fontPointSize: 10
        readonly property int fontMenuPointSize: 10
        readonly property int buttonsSize: 25
        readonly property int menuButtonsSize: 40
        readonly property int controlsButtonsSize: 40
        readonly property double tenPercent: 0.1
        readonly property double twentyPercent: 0.2
        readonly property double thirtyPercent: 0.3
        readonly property double fiftyPercent: 0.5
        readonly property double sixtyPercent: 0.6
        readonly property double oneSecondPart: 1/2
        readonly property int topMargin: 5
        readonly property string borderColor: "gray"
        readonly property int borderWidth: 1
    }

    property string address: networkAddress.text
    property int port: parseInt(networkPort.text)
    property bool manualSelected: true
    property bool autoSelected: false

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
        width: parent.width
        height: parent.height * settingsObject.twentyPercent
        anchors.top: headerRect.bottom

        GroupBox {
            title: qsTr("Сетевые настройки")
            anchors.horizontalCenter: parent.horizontalCenter

            ColumnLayout {
                anchors.fill: parent

                RowLayout {
                    width: parent.width
                    height: parent.height * settingsObject.oneSecondPart
                    Layout.alignment: Qt.AlignHCenter

                    Label {
                        id: networkAddress
                        text: "Адрес подключения"
                        font.family: settingsObject.fontFamily
                        font.pointSize: settingsObject.fontPointSize
                        Layout.alignment: Qt.AlignLeft
                    }

                    Label {
                        id: networkPort
                        text: "Порт подключения"
                        font.family: settingsObject.fontFamily
                        font.pointSize: settingsObject.fontPointSize
                        Layout.alignment: Qt.AlignRight
                    }
                }

                RowLayout {
                    width: parent.width
                    height: parent.height * settingsObject.oneSecondPart

                    TextField {
                        text: "127.0.0.1"
                        font.family: settingsObject.fontFamily
                        font.pointSize: settingsObject.fontPointSize
                        selectByMouse: true
                        horizontalAlignment: TextInput.AlignHCenter
                    }

                    TextField {
                        text: "7755"
                        font.family: settingsObject.fontFamily
                        font.pointSize: settingsObject.fontPointSize
                        selectByMouse: true
                        horizontalAlignment: TextInput.AlignHCenter
                    }
                }
            }
        }
    }

    Rectangle {
        id: sliderSettingsRect
        width: parent.width
        height: parent.height * settingsObject.twentyPercent

        anchors {
            top: networkSettingsRect.bottom
            topMargin: settingsObject.topMargin
        }

        Rectangle {
            id: sliderTitleRect
            width: parent.width
            height: parent.height * settingsObject.tenPercent

            Label {
                id: sliderTitleLbl
                text: "Настройки слайдера"
                font.family: settingsObject.fontFamily
                font.pointSize: settingsObject.fontPointSize

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        Rectangle {
            id: controlImagesRect
            width: parent.width * settingsObject.thirtyPercent
            height: parent.height * settingsObject.fiftyPercent

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            RowLayout {
                anchors.fill: parent

                Image {
                    id: uploadBtn
                    source: "resources/control_buttons/add_image.png"
                    width: settingsObject.controlsButtonsSize
                    height: settingsObject.controlsButtonsSize
                    Layout.alignment: Qt.AlignCenter
                }

                Image {
                    id: removeBtn
                    source: "resources/control_buttons/remove_image.png"
                    width: settingsObject.controlsButtonsSize
                    height: settingsObject.controlsButtonsSize
                    Layout.alignment: Qt.AlignCenter
                }
            }
        }

        Rectangle {
            id: controlModeRect
            width: settingsObject.thirtyPercent
            height: settingsObject.sixtyPercent

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: sliderTitleRect.bottom
                verticalCenter: parent.verticalCenter
                left: controlImagesRect.right
                leftMargin: 5
            }

            ButtonGroup {
                buttons: column.children
            }

            ColumnLayout {
                id: column
                anchors.fill: parent

                RadioButton {
                    id: manualSlideRB
                    text: "Вручную"
                    checked: true
                    font.family: settingsObject.fontFamily
                    font.pointSize: settingsObject.fontPointSize
                    Layout.alignment: Qt.AlignLeft

                    onClicked: if(manualSlideRB.checked) manualSelected = true
                }

                RadioButton {
                    id: autoSlideRB
                    text: "Авто переключение"
                    font.family: settingsObject.fontFamily
                    font.pointSize: settingsObject.sevenPointsSize
                    Layout.alignment: Qt.AlignLeft

                    onClicked: if(autoSlideRB.checked)autoSelected = true
                }
            }
        }
    }
}
