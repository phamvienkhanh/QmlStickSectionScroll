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
                id: item1
                section: Rectangle {
                    width: 100
                    height: 20
                    color: "black"

                    Rectangle {
                        width: 10
                        height: 5
                        color: "gray"
                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: parent.right
                        }
                        rotation: item1.isExpanded ? 90 : 0
                    }

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
                    color: "grey"
                }
            },

            StickySectionScrollItem {
                id: item2
                section: Rectangle {
                    width: 100
                    height: 35
                    color: "pink"

                    Rectangle {
                        width: 10
                        height: 5
                        color: "gray"
                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: parent.right
                        }
                        rotation: item2.isExpanded ? 90 : 0
                    }

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
                    color: "deeppink"
                }
            },

            StickySectionScrollItem {
                id: item3
                section: Rectangle {
                    width: 100
                    height: 45
                    color: "cyan"

                    Rectangle {
                        width: 10
                        height: 5
                        color: "gray"
                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: parent.right
                        }
                        rotation: item3.isExpanded ? 90 : 0
                    }

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
                    color: "darkcyan"
                }
            },

            StickySectionScrollItem {
                id: item4
                section: Rectangle {
                    width: 100
                    height: 10
                    color: "yellow"

                    Rectangle {
                        width: 10
                        height: 5
                        color: "gray"
                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: parent.right
                        }
                        rotation: item4.isExpanded ? 90 : 0
                    }

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
                    color: "darkgoldenrod"
                }
            },

            StickySectionScrollItem {
                id: item5
                height: 300
                section: Rectangle {
                    width: 100
                    height: 15
                    color: "red"

                    Rectangle {
                        width: 10
                        height: 5
                        color: "gray"
                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: parent.right
                        }
                        rotation: item5.isExpanded ? 90 : 0
                    }

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
                    color: "darkred"
                }
            }
        ]
    }

}
