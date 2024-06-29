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
            for(let item of mainContent.children) {
                const offsetTop = __offsetTop()
                const offsetBottom = __offsetBottom()

                const cbStickTop = function () {

                }

                const cbStickBottom = function (section) {
                    console.log("= cbStickBottom")
                    __reorderBottomStack()
                }

                item.layoutSection(flickview, stackTop, stackBottom, offsetTop, offsetBottom, cbStickTop, cbStickBottom)

                __updateExpandState()
            }
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
        if(item.__isExpanded) {
            // __stackNextToTop(idx)
            item.content.height = 0
        }
        else {
            __stackToTop(idx)
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

    function __updateExpandState () {
        const sz = mainContent.children.length
        for(let i = 0; i < sz; i++) {
            const item = mainContent.children[i]
            const pos = mainContent.mapToItem(root, {x: 0, y: item.y})
            const isStackTop = pos.y + item.height <= __offsetTop()
            const isStackBottom = pos.y >= flickview.height - __offsetBottom()
            if(isStackTop || isStackBottom) {
                item.__isExpanded = false
            }
            else {
                item.__isExpanded = true
            }
            // console.log("=== pos.y ", i, " ", pos.y, " ", flickview.height - stackBottom.height)
            // console.log("=== ", i, " ", isStackTop, " ", isStackBottom, " ", item.__isExpanded)
        }
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
        for(let idx =  0; idx < mainContent.children.length; idx++) {
            mainContent.children[idx].__index = idx
        }
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
}
