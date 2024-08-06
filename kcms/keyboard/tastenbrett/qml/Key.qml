/*
    SPDX-FileCopyrightText: 2019 Harald Sitter <sitter@kde.org>

    SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
*/

import QtQuick
import QtQuick.Controls

ShapeCanvas {
    id: root

    property QtObject key
    property color keyColor: key.pressed ? activePalette.highlight : key.color || activePalette.button
    property color labelColor: key.pressed ? activePalette.highlightedText : key.textColor || activePalette.buttonText

    shape: key ? key.shape : null
    lineWidth: 1
    strokeStyle: "transparent"
    fillStyle: keyColor

    onKeyColorChanged: requestPaint()

    KeyCap {
        key: parent.key
        complexShape: shape?.outlines[0].points.length > 4 ?? false

        anchors.fill: parent
        anchors.margins: 22 // arbitrary spacing to key outlines
    }

    Component.onCompleted: {
        if (!parent || !parent.row) {
            // There's implicit layout logic below when used inside a row.
            // Key may also be used standalone, so skip the layout bits.
            return;
        }

        if (parent.row.orientation === Qt.Horizontal) {
            x = 0

            for (var i in parent.children) {
                // find the furthest sibling -> it is our nearst one
                var sibling = parent.children[i]
                if (sibling === this) {
                    continue
                }
                x = Math.max(x, sibling.x + sibling.width)
            }
            if (x > 0) {
                x += key.gap // found a sibling, gap us from it
            }

            y = shape.bounds.y
        } else {
            y = 0

            for (var i in parent.children) {
                // find the furthest sibling -> it is our nearst one
                var sibling = parent.children[i]
                if (sibling === this) {
                    continue
                }
                y = Math.max(y, sibling.y + sibling.height)
            }
            if (y > 0) {
                y += key.gap // found a sibling, gap us from it
            }

            x = shape.bounds.x
        }
    }
}
