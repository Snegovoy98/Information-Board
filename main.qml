import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import QtQuick.Layouts 1.15
import QtQuick.Controls.Universal 2.15
import QtMultimedia
import "qml/common"

ApplicationWindow {
    id: mainPage
    width: 640
    height: 480
    visible: true
    title: qsTr("Information Board")

    Universal.accent: Universal.Green
    Universal.background: Universal.White

    QtObject {
        id: mainObject
        readonly property string fontFamily: "Decorative"
        readonly property int sevenPoints: 7
        readonly property int weatherFontPointSize: 10
        readonly property int fontPointSize: 14
        readonly property int clockPointSize: 20
        readonly property int weatherPointSize: 25
        readonly property double oneSecondPart: 1/2
        readonly property double oneThirdPart: 1/3
        readonly property double borderRadius: 8
        readonly property double borderWidth: 1
        readonly property string borderColor: "gray"
        readonly property double controlButtonsSize: 25
        readonly property int buttonsSize: 25
        readonly property int sliderImageSize: 35
        readonly property int weatherIconSize: 10
        readonly property double fivePercent: 0.05
        readonly property double tenPercent: 0.1
        readonly property double thirtyPercent: 0.3
        readonly property double thirtyFivePercent: 0.35
        readonly property double fiftyPercent: 0.5
        readonly property double sixtyFivePercent: 0.65
        readonly property double eightyPercent: 0.8
        readonly property double eightySevenPercent: 0.87
        readonly property double ninetyPercent: 0.9
        readonly property double opacity: 0.55
        readonly property int oneImg: 1
        readonly property int firstIndex: 0
        readonly property int lastIndex: imagesLV.count - 1
        property string videoPath: ""
        property int videoPositionValue: 0
    }

    property var modelProperty: imagesModel

    function getRequest() {
        Weather.sendRequest("https://api.weatherapi.com/v1/current.json?key=25d45d652d4e42eeb5a63758220301&q=Kiev&aqi=yes&lang=en")
    }

    function resultHandler(result) {
        var jsonResult = JSON.parse(result.toString())
        weatherCity.text = "Weather: " + jsonResult["location"]["name"]
        weatherIcon.source = "https:" + jsonResult["current"]["condition"]["icon"]
        weatherCondition.text = jsonResult["current"]["condition"]["text"]
        temperatureLbl.text = parseInt(jsonResult["current"]["temp_c"]) + " ℃"
        windValue.text = jsonResult["current"]["wind_kph"] + " km/h"
        pressureValue.text = jsonResult["current"]["pressure_in"] + " mm"
        humidityValue.text = jsonResult["current"]["humidity"] +" %"
        cloudValue.text    = jsonResult["current"]["cloud"] + " octant"
    }

    function setImagePath(path) {
        imagesModel.append({"path": path})
    }

    function setVideoPath(path) {
        mainObject.videoPath = path
    }

    TopDrawer {
        id: topDrawer
    }

    Rectangle {
        id: weatherRect
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
            id: weatherCityRect
            width: parent.width
            height: parent.height * mainObject.tenPercent
            border.color: mainObject.borderColor
            border.width: mainObject.borderWidth
            radius: 60

            Label {
                id: weatherCity
                font.family: mainObject.fontFamily
                font.pointSize: mainObject.fontPointSize
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }

            Component.onCompleted: {
                getRequest();
                Weather.replyAvailable.connect(resultHandler)
            }
        }

        Rectangle {
            id: weatherContentRect
            width: parent.width
            height: parent.height * mainObject.ninetyPercent
            anchors.top: weatherCityRect.bottom

            BorderImage {
                anchors.fill: parent
                source: "resources/background_images/cloudscape.jpg"

                Rectangle {
                    id: topSideWeatherContentRect
                    width: parent.width
                    height: parent.height * mainObject.sixtyFivePercent
                    opacity: mainObject.opacity

                    ColumnLayout {
                        anchors.fill: parent

                        Label {
                            id: weatherCondition
                            font.family: mainObject.fontFamily
                            font.pointSize: mainObject.weatherFontPointSize
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Image {
                            id: weatherIcon
                            width: mainObject.weatherIconSize
                            height: mainObject.weatherIconSize
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Label {
                            id: temperatureLbl
                            font.family: mainObject.fontFamily
                            font.pointSize: mainObject.fontPointSize
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }

                Rectangle {
                    id: bottomWeatherContentRect
                    width: parent.width
                    height: parent.height * mainObject.thirtyFivePercent
                    anchors.top: topSideWeatherContentRect.bottom
                    opacity: mainObject.opacity

                    Rectangle {
                        id: windRect
                        width: parent.width * mainObject.fiftyPercent
                        height: parent.height * mainObject.fiftyPercent

                        anchors {
                            top: parent.top
                            left: parent.left
                        }

                        RowLayout {
                            anchors.fill: parent

                            Image {
                                id: windIcon
                                source: "resources/weather_icons/wind.png"
                                width: parent.width * mainObject.fivePercent
                                height:  parent.height * mainObject.fivePercent
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Label {
                                id: windValue
                                font.family: mainObject.fontFamily
                                font.pointSize: mainObject.sevenPoints
                                font.bold: true
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    Rectangle {
                        id: pressereRect
                        width: parent.width * mainObject.fiftyPercent
                        height: parent.height * mainObject.fiftyPercent

                        anchors {
                            top: parent.top
                            right: parent.right
                        }

                        RowLayout {
                            anchors.fill: parent

                            Image {
                                id: pressureIcon
                                source: "resources/weather_icons/pressure.png"
                                width: parent.width * mainObject.fivePercent
                                height: parent.height * mainObject.fivePercent
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Label {
                                id: pressureValue
                                font.family: mainObject.fontFamily
                                font.pointSize: mainObject.sevenPoints
                                font.bold: true
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    Rectangle {
                        id: humidityRect
                        width: parent.width * mainObject.fiftyPercent
                        height: parent.height * mainObject.fiftyPercent

                        anchors {
                            left: parent.left
                            bottom: parent.bottom
                        }

                        RowLayout {
                            anchors.fill: parent

                            Image {
                                id: humidityIcon
                                source: "resources/weather_icons/humidity.png"
                                width: parent.width * mainObject.fivePercent
                                height: parent.height * mainObject.fivePercent
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Label {
                                id: humidityValue
                                font.family: mainObject.fontFamily
                                font.pointSize: mainObject.sevenPoints
                                font.bold: true
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    Rectangle {
                        id: cloudRect
                        width: parent.width * mainObject.fiftyPercent
                        height: parent.height * mainObject.fiftyPercent

                        anchors {
                            right: parent.right
                            bottom: parent.bottom
                        }

                        RowLayout {
                            anchors.fill: parent

                            Image {
                                id: cloudIcon
                                source: "resources/weather_icons/cloud.png"
                                width: parent.width * mainObject.fivePercent
                                height: parent.height * mainObject.fivePercent
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Label {
                                id: cloudValue
                                font.family: mainObject.fontFamily
                                font.pointSize: mainObject.sevenPoints
                                font.bold: true
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: repeatRequestTimer
        interval: 3600000; running: true; repeat: true
        onTriggered: getRequest()
    }

    Rectangle {
        id: imgRect
        width: parent.width * mainObject.thirtyFivePercent
        height: parent.height * mainObject.oneSecondPart
        anchors{
            left: mainSliderRect.right
        }

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
        anchors {
            left: imgRect.right
            right: parent.right
        }

        BorderImage {
            anchors.fill: parent
            source: "resources/background_images/sunset.jpg"

            ListView {
                id: clockView
                anchors.fill: parent
                orientation: ListView.Horizontal
                cacheBuffer: 2000
                snapMode: ListView.SnapOneItem
                highlightRangeMode: ListView.ApplyRange

                delegate: Clock {shift: timeShift}

                model: ListModel {
                    ListElement {timeShift: 2}
                }
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
            id: sliderContentRect
            width: parent.width * mainObject.ninetyPercent
            height: parent.height * mainObject.eightyPercent
            radius: mainObject.borderRadius
            anchors.centerIn: parent

            ListModel {id: imagesModel}

            ListView {
                id: imagesLV
                anchors.fill: parent
                orientation: ListView.Horizontal
                model: imagesModel
                snapMode: ListView.SnapOneItem


                Label {
                    text: "Add images"
                    font.family: mainObject.fontFamily
                    font.pointSize: mainObject.sevenPoints
                    font.italic: true
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                    visible: imagesModel.count > 0? false: true
                }

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
                width: mainObject.buttonsSize
                height: mainObject.buttonsSize
                visible: {
                    if(imagesLV.count <= mainObject.oneImg || imagesLV.currentIndex <= mainObject.firstIndex || settingsPage.autoSlide) {
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
                width: mainObject.buttonsSize
                height: mainObject.buttonsSize

                visible: {
                    if(imagesLV.count <= mainObject.oneImg || imagesLV.currentIndex >= mainObject.lastIndex || settingsPage.autoSlide) {
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

        Timer {
            id: autoSlide
            interval: 5000
            running: settingsPage.autoSlide? true : false
            repeat: true
            onTriggered: imagesLV.count > mainObject.oneImg && imagesLV.currentIndex >= 0 && imagesLV.currentIndex < mainObject.lastIndex?
                             imagesLV.incrementCurrentIndex() : imagesLV.currentIndex = 0
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
            id: videoContentRect
            width: parent.width
            height: parent.height * mainObject.eightySevenPercent

            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }

            MediaPlayer {
                id: mediaPlayer
                source: mainObject.videoPath
                audioOutput: AudioOutput{}
                videoOutput: videoOutput
            }

            VideoOutput {
                id: videoOutput
                anchors.fill: parent
                fillMode: VideoOutput.Stretch

                Slider {
                    id: slider
                    width: parent.width
                    anchors.bottom: parent.bottom
                    value: mediaPlayer.position
                    to: mediaPlayer.duration
                    visible: mediaPlayer.hasVideo
                    onPressedChanged: {
                        mediaPlayer.setPosition(slider.value)
                    }
                }
            }
        }

        Rectangle {
            id: playButtonsRect
            width: parent.width
            height: parent.height * mainObject.tenPercent
            border.color: mainObject.borderColor
            border.width: mainObject.borderWidth
            anchors {
                top: videoContentRect.bottom
                bottom: parent.bottom
            }

            Loader {
                id: playloader
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }
                sourceComponent: playComponent

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }


            Component {
                id: playComponent

                Image {
                    source: "resources/buttons_img/play.png"
                    sourceSize.width: mainObject.buttonsSize
                    sourceSize.height: mainObject.buttonsSize

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            mediaPlayer.play()
                            playloader.sourceComponent = stopComponent
                        }
                    }
                }
            }

            Component {
                id: stopComponent

                Image {
                    source: "resources/buttons_img/pause.png"
                    sourceSize.width: mainObject.buttonsSize
                    sourceSize.height: mainObject.buttonsSize

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            mainObject.videoPositionValue = slider.value
                            mediaPlayer.stop()
                            playloader.sourceComponent = playComponent
                            mediaPlayer.setPosition(mainObject.videoPositionValue)
                        }
                    }
                }
            }
        }
    }

    SettingsPage {id: settingsPage; width: parent.width; height: parent.height; visible: false}
}
