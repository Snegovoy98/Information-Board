import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import "qml/common"

Page {
    id: settingsPage
    width: ApplicationWindow.width
    height: ApplicationWindow.height

    QtObject {
        id: settingsObject
        readonly property string fontFamily: "Decorative"
        readonly property int fontPointMessageSize: 7
        readonly property int fontPointSize: 10
        readonly property int fontMenuPointSize: 10
        readonly property int buttonsSize: 25
        readonly property int menuButtonsSize: 25
        readonly property int controlsButtonsSize: 40
        readonly property int buttonWidth: 90
        readonly property double tenPercent: 0.1
        readonly property double twentyPercent: 0.2
        readonly property double thirtyPercent: 0.3
        readonly property double fiftyPercent: 0.5
        readonly property double sixtyPercent: 0.6
        readonly property double oneSecondPart: 1/2
        readonly property int topMargin: 5
        readonly property string defaultColor: "green"
        readonly property string errorColor: "red"
        readonly property string borderColor: "gray"
        readonly property int borderWidth: 1
        readonly property int maxImagesCount: 15
    }

    property bool  manualSlide: true
    property bool  autoSlide: false
    property var imagesModelProperty


    TopDrawer {
        id: topDrawer
    }

    Rectangle {
        id: headerRect
        width: parent.width
        height: parent.height * settingsObject.tenPercent

        Image {
            id: openDrawerImg
            source: "resources/buttons_img/open_btn.png"
            width: settingsObject.menuButtonsSize
            height: settingsObject.menuButtonsSize

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: topDrawer.open()
            }
        }
    }

    Rectangle {
        id: sliderSettingsRect
        width: parent.width
        height: parent.height * settingsObject.thirtyPercent

        anchors {
            top: headerRect.bottom
            topMargin: settingsObject.topMargin
        }

        Rectangle {
            id: sliderTitleRect
            width: parent.width
            height: parent.height * settingsObject.tenPercent

            Label {
                id: sliderTitleLbl
                text: "Slider settings"
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
                width: parent.width
                height: parent.height

                Image {
                    id: uploadBtn
                    source: "resources/control_buttons/add_image.png"
                    width: settingsObject.controlsButtonsSize
                    height: settingsObject.controlsButtonsSize
                    Layout.alignment: Qt.AlignCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            sliderImagesDialog.open()
                            imagesModelProperty = mainPage.modelProperty
                        }
                    }
                }

                Image {
                    id: removeBtn
                    source: "resources/control_buttons/remove_image.png"
                    width: settingsObject.controlsButtonsSize
                    height: settingsObject.controlsButtonsSize
                    Layout.alignment: Qt.AlignCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            sliderImagesPopup.open()
                            sliderImagesPopup.imagesModel = imagesModelProperty
                        }
                    }
                }
            }
        }

        FileDialog {
            id: sliderImagesDialog
            nameFilters: ["Images files: *.jpg *.jpeg *.png"]
            onAccepted: {
                if(mainPage.modelProperty.count <= settingsObject.maxImagesCount) {
                    setImagePath(sliderImagesDialog.selectedFile)
                    helperMessage.color = settingsObject.defaultColor
                } else {
                    helperMessage.color = settingsObject.errorColor
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
                id: group
            }

            ColumnLayout {
                id: column
                anchors.fill: parent

                RadioButton {
                    id: manualSlideRB
                    text: "Manual"
                    checked: true
                    font.family: settingsObject.fontFamily
                    font.pointSize: settingsObject.fontPointSize
                    Layout.alignment: Qt.AlignLeft
                    ButtonGroup.group: group
                    onClicked: {
                        if(manualSlideRB.checked) {
                            manualSlide = true
                            autoSlide = false
                        }
                    }
                }

                RadioButton {
                    id: autoSlideRB
                    text: "Auto"
                    font.family: settingsObject.fontFamily
                    font.pointSize: settingsObject.sevenPointsSize
                    Layout.alignment: Qt.AlignLeft
                    checked: false
                    ButtonGroup.group: group
                    onClicked: {
                        if(autoSlideRB.checked) {
                            autoSlide = true
                            manualSlide = false
                        }
                    }
                }
            }
        }

        Label {
            id: helperMessage
            text: "Max count of images - 15"
            font.family: settingsObject.fontFamily
            font.pointSize: settingsObject.fontPointMessageSize
            font.italic: true
            color: settingsObject.defaultColor
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
        }
    }

    Rectangle {
        id: videoSettingsRect
        width: parent.width
        height: parent.height & settingsObject.twentyPercent

        anchors {
            top: sliderSettingsRect.bottom
            topMargin: settingsObject.topMargin
            bottom: buttonSaveRect.top
            bottomMargin: settingsObject.topMargin
        }

        Rectangle {
            id: videoSettingsTitleRect
            width: parent.width
            height: parent.height * settingsObject.tenPercent

            Label {
                id: videoSettingsTitleLbl
                text: "Videoplayer settings"
                font.family: settingsObject.fontFamily
                font.pointSize: settingsObject.fontPointSize

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        Rectangle {
            id: videoSettingsContentRect
            width: parent.width
            height: parent.height * settingsObject.thirtyPercent
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            ColumnLayout {
                anchors.fill: parent

                Image {
                    id: addVideoRect
                    source: "resources/control_buttons/add_video.png"
                    width: settingsObject.controlsButtonsSize
                    height: settingsObject.controlsButtonsSize
                    Layout.alignment: Qt.AlignCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: videoFileDialog.open()
                    }
                }

                Label {
                    text: "Add video"
                    font.family: settingsObject.fontFamily
                    font.pointSize: settingsObject.fontPointSize
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }

    FileDialog {
        id: videoFileDialog
        nameFilters: ["Video files: *.mp4 *.avi"]
        onAccepted: setVideoPath(videoFileDialog.selectedFile)
    }

    Rectangle {
        id: buttonSaveRect
        width: parent.width
        height: parent.height * settingsObject.tenPercent
        anchors.bottom: parent.bottom

        Label {
            id: messageLbl
            text: "??All rights reserved"
            font.family: settingsObject.fontFamily
            font.pointSize: settingsObject.fontPointSize
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
        }

        Label {
            id: versionLbl
            text: "v. 1.0.0"
            font.family: settingsObject.fontFamily
            font.pointSize: settingsObject.fontPointSize
            anchors {
                right: parent.right
                bottom: parent.bottom
            }
        }
    }

    RemoveSliderImagesPopup {
        id: sliderImagesPopup
        anchors.centerIn: parent
    }
}
