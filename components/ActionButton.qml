/*
 *   Copyright 2018 Marian Arlt <marianarlt@icloud.com>
 *   Copyright 2016 David Edmundson <davidedmundson@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 3 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.2
import QtQuick.Controls 1.4

Item {
    id: root

    property alias text: label.text
    property alias iconSource: icon.source
    property alias containsMouse: mouseArea.containsMouse
    signal clicked

    activeFocusOnTab: true
    opacity: mouseArea.containsMouse || activeFocus ? 1 : 0.6
    property int iconSize

    implicitWidth: Math.max(iconSize + 30, label.contentWidth)
    implicitHeight: iconSize + 30, label.implicitHeight

    Image {
        id: icon
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        anchors.topMargin: height / 2

        width: iconSize
        height: iconSize
    }

    Label {
        id: label

        font.pointSize: iconSize / 3
        renderType: Text.QtRendering
        anchors {
            top: icon.bottom
            left: parent.left
            right: parent.right
            topMargin: label.height / 2
        }
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        color: "white"
        font.underline: root.activeFocus
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        onClicked: root.clicked()
        anchors.top: icon.top
        anchors.bottom: label.bottom
        anchors.left: (label.width > icon.width) ? label.left : icon.left
        anchors.right: (label.width > icon.width) ? label.right : icon.right
    }

    Keys.onEnterPressed: clicked()
    Keys.onReturnPressed: clicked()

    Accessible.onPressAction: clicked()
    Accessible.role: Accessible.Button
    Accessible.name: label.text
}
