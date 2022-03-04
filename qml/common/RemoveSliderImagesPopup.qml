import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Universal 2.15

Popup {
    id: removeSliderImages
    width: 350
    height: 350

    QtObject {
        id: sliderImagesPropertyObject
        readonly property string fontFamily: "Helvetica"
        readonly property int fontPointSize: 12
        readonly property double thirtyPercent: 0.3
        readonly property double fiftyPercent: 0.5
        readonly property double eightyPercent: 0.8
        readonly property double ninetyFivePercent: 0.95
        readonly property int iconSize: 100
        property var indexesArray: []
    }

    property var imagesModel

        ListView {
            id: imagesView
            width: parent.width * sliderImagesPropertyObject.ninetyFivePercent
            height: parent.height * sliderImagesPropertyObject.eightyPercent
            model: imagesModel

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            clip: true

            focus: true

            ScrollBar.vertical: verticalSb

            header: Label {
                text: "Выберите изображение для удаления"
                font.family: sliderImagesPropertyObject.fontFamily
                font.pointSize: sliderImagesPropertyObject.fontPointSize
                font.bold: true
            }

            delegate: Rectangle {
                id: mainDelegateRect
                width: imagesView.width * sliderImagesPropertyObject.eightyPercent
                height: imagesView.height * sliderImagesPropertyObject.fiftyPercent

                Rectangle {
                    id: imgRect
                    width: parent.width * sliderImagesPropertyObject.fiftyPercent
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }

                    Image {
                        id: img
                        source: model.path
                        sourceSize.width: sliderImagesPropertyObject.iconSize
                        sourceSize.height: sliderImagesPropertyObject.iconSize
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            verticalCenter: parent.verticalCenter
                        }
                    }
                }


                Rectangle {
                    id: checboxRect
                    width: parent.width * sliderImagesPropertyObject.fiftyPercent
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: imgRect.right
                    }
                    CheckBox {
                        id: imagesCB

                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            verticalCenter: parent.verticalCenter
                        }

                        onClicked: sliderImagesPropertyObject.indexesArray.push(index)
                    }
                }
            }
        }

        ScrollBar {
            id: verticalSb
            hoverEnabled: true
            active: pressed || hovered
            orientation: Qt.Vertical
            size: imagesView.height * sliderImagesPropertyObject.fiftyPercent
            anchors.top: imagesView.top
            anchors.right: imagesView.right
            anchors.bottom: imagesView.bottom
        }

        Button {
            id: removeBtn
            text: "Удалить"
            font.family: sliderImagesPropertyObject.fontFamily
            font.pointSize: sliderImagesPropertyObject.fontPointSize
            highlighted: true
            anchors {
                top: imagesView.bottom
                horizontalCenter: parent.horizontalCenter
            }

            onClicked: {
                for(var index = 0; index < sliderImagesPropertyObject.indexesArray.length; ++index) {
                   imagesModel.remove(sliderImagesPropertyObject.indexesArray[index])
                    sliderImagesPropertyObject.indexesArray.pop(index)
                }
            }
        }
}
