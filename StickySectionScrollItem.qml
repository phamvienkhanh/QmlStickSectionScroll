import QtQuick

Item {
    id: root

    property Item section
    property Item content

    readonly property bool isExpanded: __isExpandedInternal && !__isStackTop && !__isStackBottom

    property bool __isStackTop: false
    property bool __isStackBottom: false
    property int __index: 0
    property bool __isExpandedInternal: true

    height: sectionHolder.height + contentHolder.height
    width: Math.max(content.width, section.width)

    Item {
        id: sectionHolder
        width: section.width
        height: section.height

        Item {
            id: boundSection

            property int __index: root.__index
            width: section.width
            height: section.height
            children: [section]
        }
    }

    Item {
        id: contentHolder
        y: section.height
        visible: root.__isExpandedInternal
        width: content.width
        height: root.__isExpandedInternal ? content.height : 0
        children: [content]
    }

    function layoutSection(viewport, stackTop, stackBottom, offsetTop, offsetBottom, cbStickTop, cbStickBottom) {
        const pos = sectionHolder.mapToItem(viewport, {x: sectionHolder.x, y: sectionHolder.y})
        if(pos.y <= offsetTop - (!__isStackTop ? 0 : boundSection.height)) {
            if(!__isStackTop) {
                __isStackTop = true
                boundSection.parent = stackTop
                boundSection.y = offsetTop
                cbStickTop(boundSection)
            }
        }
        else if(pos.y >= viewport.height - offsetBottom - (!__isStackBottom ? boundSection.height : 0)) {
            if(!__isStackBottom) {
                __isStackBottom = true
                boundSection.parent = stackBottom
                cbStickBottom(boundSection)
            }
        }
        else {
            __isStackTop = false
            __isStackBottom = false
            if(section.parent !== sectionHolder) {
                boundSection.parent = sectionHolder
                boundSection.y = 0
            }
        }
    }

    function expand () {
        __isExpandedInternal = true
    }

    function collapse () {
        __isExpandedInternal = false
    }
}
