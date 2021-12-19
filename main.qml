import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Dialogs

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Information Board")

    QtObject {
        id: mainObject
        readonly property string fontFamily: "Decorative"
        readonly property int fontPointSize: 14
        readonly property int clockPointSize: 20
        readonly property double oneSecondPart: 1/2
        readonly property double oneThirdPart: 1/3
        readonly property double borderRadius: 8
        readonly property double borderWidth: 1
        readonly property string borderColor: "gray"
        readonly property double controlButtonsSize: 15
        readonly property int sliderButtonsSize: 25
        readonly property int sliderImageSize: 35
        readonly property double tenPercent: 0.1
        readonly property double fifteenPercent: 0.15
        readonly property double thirtyPercent: 0.3
        readonly property double eightyPercent: 0.8
        readonly property double ninetyPercent: 0.9
        readonly property int oneImg: 1
        readonly property int firstIndex: 0
        readonly property int lastIndex: imagesLV.count - 1
    }

    BorderImage {
        id: borderImg
        source: "resources/background_images/Background.jpg"
        anchors.fill: parent

        Rectangle {
            id: mainSliderRect
            width: parent.width * mainObject.oneThirdPart
            height: parent.height * mainObject.oneSecondPart
            radius: mainObject.borderRadius

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
            id: clockRect
            width: parent.width * mainObject.oneSecondPart
            height: parent.height * mainObject.thirtyPercent
            radius: mainObject.borderRadius
            border.color: mainObject.borderColor
            border.width: mainObject.borderWidth
            anchors.right: parent.right

            Label {
                id: timeLbl
                text: new Date().toLocaleTimeString(Qt.locale, Locale.ShortFormat)
                anchors.fill: parent
                font.family: mainObject.fontFamily
                font.pointSize: mainObject.clockPointSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
