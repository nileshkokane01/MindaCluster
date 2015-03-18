import QtQuick 2.1

FocusScope {
    clip: true
    ListView {
        id: list2
        x:32;height:150;//width:250;
        focus:true
        orientation: ListView.Vertical
        keyNavigationWraps :true
        anchors.margins: 3
        model:myMenu; cacheBuffer: 400
        delegate: ListmenuDelegate {}

        Behavior on y {
            NumberAnimation { duration: 600; easing.type: Easing.OutQuint }
        }
    }

}
