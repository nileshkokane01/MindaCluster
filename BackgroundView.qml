import QtQuick 2.1

FocusScope {
    clip: true

    ListView {
        id: backgroundView
        x:50;width:370;height:370
        focus: true
        orientation: ListView.Horizontal
        keyNavigationWraps :true
        highlightMoveDuration:250
        model:backgroundOption; cacheBuffer: 100
        delegate: BackgrouldDelegate {}

        Behavior on y {
            NumberAnimation { duration: 600; easing.type: Easing.OutQuint }
        }
    }

    ListModel{
        id:backgroundOption


        ListElement{
            sourcee:"image/Skin_9.png"
            scalee:0.22
            widthh:1082
            Heightt:480
        }
        ListElement{
            sourcee:"image/Skin_14.png"
            scalee:0.22
            widthh:1082
            Heightt:480
        }
        ListElement{
            sourcee:"image/Skin_15.png"
            scalee:0.22
            widthh:1082
            Heightt:480
        }
       /* ListElement{
            sourcee:"image/Skin_16.png"
            scalee:0.22
            widthh:1082
            Heightt:480
        }*/
        ListElement{
            sourcee:"image/Skin_4.png"
            scalee: 0.22
            widthh:1082
            Heightt:480
        }
        ListElement{
            sourcee:"image/Skin_6.png"
            scalee:0.22
            widthh:1082
            Heightt:480
        }
        ListElement{
            sourcee:"image/Skin_7.png"
            scalee:0.22
            widthh:1082
            Heightt:480
        }
        ListElement{
            sourcee:"image/Skin_11.png"
            scalee:0.22
            widthh:1082
            Heightt:480
        }

    }

}
