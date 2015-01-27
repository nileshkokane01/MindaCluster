import QtQuick 2.1

FocusScope {
    clip: true

    ListView {
        id: pointerView
        x:50;width:300;height:300
        focus: true
        orientation: ListView.Horizontal
        model:switch(cluster.configurableBackground_index){case 9:skin_9_pointerOption;break;case 3:skin_3_pointerOption;break;case 12:skin_12_pointerOption;break;default:pointerOption;}
        cacheBuffer: 100
        delegate: PointerDelegate {}

        Behavior on y {
            NumberAnimation { duration: 600; easing.type: Easing.OutQuint }
        }
    }

    ListModel{
        id:pointerOption

        ListElement{
            sourcee:"image/Pointer1.png"
            scalee:1
        }
        ListElement{
            sourcee:"image/Pointer2.png"
            scalee:1
        }
        ListElement{
            sourcee:"image/Pointer3.png"
            scalee:1
        }
        ListElement{
            sourcee:"image/Pointer4.png"
            scalee:1
        }
        ListElement{
            source:"image/Pointer5.png"
        }
        ListElement{
            sourcee:"image/Pointer6.png"
            scalee:1
        }
        ListElement{
            sourcee:"image/Skin_14_Speedo_RPM_Pointer.png"
            scalee:1
        }
    }

    ListModel{
        id:skin_9_pointerOption

        ListElement{
            sourcee:"image/Skin_9_RPM_Pointer1.png"
            scalee:1
        }
        ListElement{
            sourcee:"image/Skin_9_RPM_Pointer2.png"
            scalee:1
        }
        ListElement{
            sourcee:"image/Skin_9_RPM_Pointer3.png"
            scalee:1
        }
        ListElement{
            sourcee:"image/Skin_9_RPM_Pointer4.png"
            scalee:1
        }
        ListElement{
            sourcee:"image/Skin_9_RPM_Pointer5.png"
            scalee:1
        }
    }

    ListModel{
        id:skin_3_pointerOption

        ListElement{
            sourcee:"image/Skin_Blank_Speedo_RPM_Pointer.png"
            scalee:0.3
        }
    }

    ListModel{
        id:skin_12_pointerOption

        ListElement{
            sourcee:"image/Skin_Blank_Speedo_RPM_Pointer.png"
            scalee:0.3
        }
    }
}
