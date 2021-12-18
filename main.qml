import QtQuick
import QtQuick.Controls 2.15

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Information Board")

    QtObject {
        id: mainObject
        readonly property string fontFamily: "Decorative"
        readonly property int fontPointSize: 14
        readonly property double oneSecondPart: 1/2
        readonly property double oneThirdPart: 1/3
        readonly property double borderRadius: 8
        readonly property int sliderButtonsSize: 25
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


            ListModel {
                id: imagesModel
                ListElement {
                    path: "resources/slider_images/Phoenix.jpg"
                }
            }

            ListView {
                id: imagesLV
                anchors.fill: parent
                orientation: Qt.Vertical

                model: imagesModel

                delegate: Image {
                    width: imagesLV.width
                    height: imagesLV.height
                    source: path
                    fillMode: Image.PreserveAspectFit
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
                }

                Image {
                    id: arrowRightImg
                    source: "resources/buttons_img/arrow_right.png"
                    width: mainObject.sliderButtonsSize
                    height: mainObject.sliderButtonsSize

                    visible: {
                        if(imagesLV.count <= mainObject.oneImg || imagesLV.currentIndex <= mainObject.lastIndex) {
                            false
                        } else if(imagesLV.count > mainObject.oneImg && imagesLV.currentIndex < mainObject.lastIndex) {
                            true
                        }
                    }

                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
