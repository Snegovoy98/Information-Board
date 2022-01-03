import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import "qml/common"

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Information Board")

    QtObject {
        id: mainObject
        readonly property string fontFamily: "Decorative"
        readonly property int fivePoints: 5
        readonly property int menuElemsPointSize: 7
        readonly property int fontPointSize: 14
        readonly property int clockPointSize: 20
        readonly property double oneSecondPart: 1/2
        readonly property double oneThirdPart: 1/3
        readonly property double borderRadius: 8
        readonly property double borderWidth: 1
        readonly property string borderColor: "gray"
        readonly property double controlButtonsSize: 25
        readonly property int sliderButtonsSize: 25
        readonly property int sliderImageSize: 35
        readonly property double tenPercent: 0.1
        readonly property double fifteenPercent: 0.15
        readonly property double thirtyPercent: 0.3
        readonly property double thirtyFivePercent: 0.35
        readonly property double fourtyPercent: 0.4
        readonly property double fiftyPercent: 0.5
        readonly property double sixtyFivePercent: 0.65
        readonly property double eightyPercent: 0.8
        readonly property double ninetyPercent: 0.9
        readonly property int oneImg: 1
        readonly property int firstIndex: 0
        readonly property int lastIndex: imagesLV.count - 1
    }

    Drawer {
        id: topDrawer
        edge: Qt.TopEdge
        width: parent.width
        height: parent.height * mainObject.tenPercent

        Image {
            id: settingsLogo
            width: mainObject.controlButtonsSize
            height: mainObject.controlButtonsSize
            source: "resources/buttons_img/settings.png"
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 15
            }

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
            anchors {
                top: settingsLogo.bottom
                right: parent.right
                rightMargin: 5
            }
        }
    }

    Rectangle {
        id: wheatherRect
        width: parent.width * mainObject.thirtyFivePercent
        height: parent.height * mainObject.oneSecondPart
        border.color: mainObject.borderColor
        border.width: mainObject.borderWidth
        radius: mainObject.borderRadius

        anchors {
            left: parent.left
            top: parent.top
        }

        Rectangle {
            id: wheaterTitleRect
            width: parent.width
            height: parent.height * mainObject.tenPercent
            border.color: mainObject.borderColor
            border.width: mainObject.borderWidth

            Label {
                id: wheatherTitle
                text: "Погода в Киеве"
                font.family: mainObject.fontFamily
                font.pointSize: mainObject.fontPointSize
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Rectangle {
        id: imgRect
        width: parent.width * mainObject.fourtyPercent
        height: parent.height * mainObject.oneSecondPart
        anchors.left: mainSliderRect.right

        Image {
            id: backgroundImg
            anchors.fill: parent
            source: "resources/background_images/image.jpg"

            Image {
                id: openDrawerBtn
                width: mainObject.controlButtonsSize
                height: mainObject.controlButtonsSize
                source: "resources/buttons_img/open_btn.png"
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: topDrawer.open()
                }
            }
        }
    }

    Rectangle {
        id: clockRect
        width: parent.width * mainObject.thirtyPercent
        height: parent.height * mainObject.fiftyPercent
        radius: mainObject.borderRadius
        border.color: mainObject.borderColor
        border.width: mainObject.borderWidth
        anchors.right: parent.right

        ListView {
            id: clockView
            anchors.fill: parent
            orientation: ListView.Horizontal
            cacheBuffer: 2000
            snapMode: ListView.SnapOneItem
            highlightRangeMode: ListView.ApplyRange

            delegate: Clock {city: cityName; shift: timeShift}

            model: ListModel {
                ListElement {cityName: "Kiev"; timeShift: 2}
            }
        }
    }

    Rectangle {
        id: mainSliderRect
        width: parent.width * mainObject.thirtyFivePercent
        height: parent.height * mainObject.oneSecondPart
        radius: mainObject.borderRadius

        anchors {
            left: parent.left
            bottom: parent.bottom
        }

        Rectangle {
            id: controlButtonsRect
            width: parent.width
            height: parent.height * mainObject.tenPercent
            radius: mainObject.borderRadius
            anchors.top: parent.top

            Rectangle {
                id: addBtnRect
                width: parent.width * mainObject.fifteenPercent
                height: parent.height
                anchors.right: parent.right

                Image {
                    id: addBtn
                    source: "resources/control_buttons/add_btn.png"
                    width: mainObject.controlButtonsSize
                    height: mainObject.controlButtonsSize

                    anchors {
                        horizontalCenter: parent.horizontal
                        verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: imagesSelectedDialog.open()
                    }
                }
            }

            Rectangle {
                id: rmBtnRect
                width: parent.width * mainObject.fifteenPercent
                height: parent.height
                anchors.left: parent.left

                Image {
                    id: rmBtn
                    source: "resources/control_buttons/rm_btn.png"
                    width: mainObject.controlButtonsSize
                    height: mainObject.controlButtonsSize
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }
                }
            }

            FileDialog {
                id: imagesSelectedDialog
                nameFilters: ["Images files (*.jpg, *.jpeg, *.png)"]
            }
        }

        Rectangle {
            id: sliderContentRect
            width: parent.width * mainObject.ninetyPercent
            height: parent.height * mainObject.eightyPercent
            radius: mainObject.borderRadius
            anchors.centerIn: parent

            ListModel {
                id: imagesModel

                ListElement {
                    path: "resources/slider_images/Phoenix.jpg"
                }
                ListElement {
                    path: "resources/slider_images/Phoenix.jpg"
                }
            }

            ListView {
                id: imagesLV
                anchors.fill: parent
                orientation: ListView.Horizontal
                model: imagesModel
                snapMode: ListView.SnapOneItem

                delegate: Image {
                    id: delegateImg
                    width: sliderContentRect.width
                    height: sliderContentRect.height
                    source: path
                    fillMode: Image.PreserveAspectCrop
                    visible: ListView.isCurrentItem? true: false

                    states: State {
                        name: "moved"
                        when: arrowLeftMouseArea.pressed || arrowRightMouseArea.pressed
                        PropertyChanges {
                            target: delegateImg
                            x: 0
                            y: 0
                        }
                    }
                    transitions: Transition {
                        NumberAnimation {
                            properties: "x,y"; easing.type: Easing.OutCirc
                        }
                    }
                }
            }

            Image {
                id: arrowLeftImg
                source: "resources/buttons_img/arrow_left.png"
                width: mainObject.sliderButtonsSize
                height: mainObject.sliderButtonsSize
                visible: {
                    if(imagesLV.count <= mainObject.oneImg || imagesLV.currentIndex <= mainObject.firstIndex) {
                        false
                    } else if(imagesLV.count > mainObject.oneImg && imagesLV.currentIndex > mainObject.firstIndex) {
                        true
                    }
                }

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    id: arrowLeftMouseArea
                    anchors.fill: parent
                    onClicked: imagesLV.decrementCurrentIndex()
                }
            }

            Image {
                id: arrowRightImg
                source: "resources/buttons_img/arrow_right.png"
                width: mainObject.sliderButtonsSize
                height: mainObject.sliderButtonsSize

                visible: {
                    if(imagesLV.count <= mainObject.oneImg || imagesLV.currentIndex >= mainObject.lastIndex) {
                        false
                    } else if(imagesLV.count > mainObject.oneImg && imagesLV.currentIndex < mainObject.lastIndex) {
                        true
                    }
                }

                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    id: arrowRightMouseArea
                    anchors.fill: parent
                    onClicked: imagesLV.incrementCurrentIndex()
                }
            }
        }
    }

    Rectangle {
        id: videoRect
        width: parent.width * mainObject.sixtyFivePercent
        height: parent.height * mainObject.oneSecondPart
        border.color: mainObject.borderColor
        border.width: mainObject.borderWidth
        radius: mainObject.borderRadius

        anchors {
            right: parent.right;
            bottom: parent.bottom
        }

        Rectangle {
            id: settingsRect
            width: parent.width
            height:   parent.height * mainObject.tenPercent
            border.color: mainObject.borderColor
            border.width: mainObject.borderWidth

            Image {
                id: addVideoBtn
                source: "resources/control_buttons/add_video_btn.png"
                width: mainObject.controlButtonsSize
                height: mainObject.controlButtonsSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: videoDialog.open()
                }
            }

            Label {
                id: videoTitleLbl
                text: "Название видео"
                font.family: mainObject.fontFamily
                font.pointSize: mainObject.fontPointSize
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.vetricalCenter
                }
            }
        }

        FileDialog {
            id: videoDialog
            nameFilters: ["Video filter (*.mp4)"]
        }
    }

    SettingsPage {id: settingsPage; width: parent.width; height: parent.height; visible: false}
}
