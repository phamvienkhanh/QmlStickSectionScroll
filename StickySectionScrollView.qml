import QtQuick

import QtQml.Models

Item {
    id: root

    property alias items: mainContent.children

    Component.onCompleted: {
        __updateChildrenIndex()
    }

    Flickable {
        id: flickview
        anchors.fill: parent
        contentHeight: mainContent.height
        contentWidth: parent.width
        clip: true

        Column {
            id: mainContent
            children: root.items
        }

        onContentYChanged: {
            __updateLayout()
        }

        onContentHeightChanged: {
            __updateLayout()
        }
    }

    Item {
        id: stackTop
    }

    Item {
        id: stackBottom
        anchors.bottom: parent.bottom
    }

    function toggleExpand(idx) {
        const item = mainContent.children[idx]

        console.log("item.__isExpandedInternal ", item.__isExpandedInternal)
        console.log("item.__isStackTop ", item.__isStackTop)
        console.log("item.__isStackBottom ", item.__isStackBottom)

        if(item.__isExpandedInternal) {
            item.collapse()
        }
        else {
            item.expand()
        }
    }

    function __stackToTop (idx) {
        let ttItemH = 0
        for(let i = 0; i < idx; i++) {
            ttItemH += mainContent.children[i].content.height
        }
        flickview.contentY = ttItemH
    }

    function __stackNextToTop (idx) {
        if(idx + 1 < mainContent.children.length) {
            __stackToTop(idx + 1)
        }
        else {
            __stackToTop(idx)
        }
    }

    function __expandFromBottom () {

    }

    function __offsetTop () {
        let offset = 0
        for(let item of stackTop.children) {
            offset += item.height
        }
        return offset
    }

    function __offsetBottom () {
        let offset = 0
        for(let item of stackBottom.children) {
            offset += item.height
        }
        return offset
    }

    function __updateChildrenIndex () {
        console.log("=== __updateChildrenIndex")
        for(let idx =  0; idx < mainContent.children.length; idx++) {
            mainContent.children[idx].__index = idx
        }
        __reorderBottomStack()
    }

    function __reorderBottomStack () {
        let items = []
        for(let it of stackBottom.children) {
            items.push(it)
        }

        items.sort((l, r) => l.__index - r.__index)

        let stackH = 0
        for(let i = items.length - 1; i >= 0; i--) {
            const stackItem = items[i]
            stackH -= stackItem.height
            stackItem.y = stackH
            stackItem.x = 100
        }

        return items
    }

    function __updateLayout () {
        for(let item of mainContent.children) {
            const offsetTop = __offsetTop()
            const offsetBottom = __offsetBottom()

            const cbStickTop = function () {
                if(!item.__isExpandedInternal) {
                    item.expand()
                    flickview.contentY += item.content.height
                }
            }

            const cbStickBottom = function (section) {
                console.log("= cbStickBottom")
                __reorderBottomStack()

                if(!item.__isExpandedInternal) {
                    item.expand()
                }
            }

            item.layoutSection(flickview, stackTop, stackBottom, offsetTop, offsetBottom, cbStickTop, cbStickBottom)
        }
    }
}
