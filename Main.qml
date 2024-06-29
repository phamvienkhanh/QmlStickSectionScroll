import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")


    StickySectionScrollView {
        id: stickScroll
        width: 200
        height: 300

        items: [
            StickySectionScrollItem {
                section: Rectangle {
                    width: 100
                    height: 20
                    color: "black"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            stickScroll.toggleExpand(0)
                        }
                    }
                }
                content: Rectangle {
                    width: 100
                    height: 300
                    color: "blue"
                }
            },

            StickySectionScrollItem {
                id: item2
                section: Rectangle {
                    width: 100
                    height: 35
                    color: "yellow"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            stickScroll.toggleExpand(1)
                        }
                    }
                }
                content: Rectangle {
                    width: 100
                    height: 100
                    color: "blue"
                }
            },

            StickySectionScrollItem {
                section: Rectangle {
                    width: 100
                    height: 45
                    color: "cyan"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            stickScroll.toggleExpand(2)
                        }
                    }
                }
                content: Rectangle {
                    width: 100
                    height: 50
                    color: "blue"
                }
            },

            StickySectionScrollItem {
                section: Rectangle {
                    width: 100
                    height: 10
                    color: "crimson"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            stickScroll.toggleExpand(3)
                        }
                    }
                }
                content: Rectangle {
                    width: 100
                    height: 50
                    color: "blue"
                }
            },

            StickySectionScrollItem {
                height: 300
                section: Rectangle {
                    width: 100
                    height: 15
                    color: "darkcyan"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            stickScroll.toggleExpand(4)
                        }
                    }
                }
                content: Rectangle {
                    width: 100
                    height: 100
                    color: "blue"
                }
            }
        ]
    }

}
