import QtQuick 2.1

Item {
    id: delDial
    width: ListView.view.width; height: 250; anchors.leftMargin: 10; anchors.rightMargin: 10

    Rectangle {
        id: dialRec
        anchors.centerIn: parent; width: 170; height: 140
        color: "transparent"
        antialiasing: true
        radius: 10
        Rectangle { anchors.fill: parent; anchors.margins: 3; color: "#0d0f11"; antialiasing: true; radius: 8 }
    }

    Image{
        id:dialImage
        anchors.centerIn:dialRec
        source: sourcee //modelData
        scale: scalee
    }

    Keys.onSpacePressed: {

        switch(cluster.configurableBackground_index){


        case 3:
            switch(index){
            case 0:
                cluster.configurableDial="image/Skin_3_Speedo_Dial.png"
                cluster.skin_3_configurableDial_index = 1
                cluster.skin_12_configurablePointer_index = 1;
                break;
            case 1:
                cluster.configurableDial="image/Skin_3_Speedo_Dial2.png"
                cluster.skin_3_configurableDial_index = 2
                cluster.skin_12_configurablePointer_index = 3;
                break;
            }
            break;

        case 9:
            switch(index){
            case 0:
                cluster.configurableDial="image/Skin_9_Speedo.png"
                cluster.skin_9_configurableDial_index = 1
                break;
            case 1:
                cluster.configurableDial="image/Skin_9_Speedo1.png"
                cluster.skin_9_configurableDial_index = 2
                break;
           case 2:
                  cluster.configurableDial="image/Skin_9_Speedo2.png"
                  cluster.skin_9_configurableDial_index = 3
                  break;
            }
            break;

        case 12:
            switch(index){
            case 0:
                cluster.configurableDial="image/Skin_9_Speedo.png"
                cluster.skin_Blank_configurableDial_index = 1
                cluster.skin_12_configurablePointer_index = 1;
                break;
            case 1:
                cluster.configurableDial="image/Skin_9_Speedo1.png"
                cluster.skin_Blank_configurableDial_index = 2
                cluster.skin_12_configurablePointer_index = 2;
                break;
            }
            break;



        default:
            switch(index){
            case 0:
                cluster.configurableDial="image/RPM_01.png"
                cluster.configurableDial_index = 1

                rpm_active.opacity   = cluster.startFlag==true? 0:0
                needle.x             = cluster.startFlag==true?-76:74 //-79:74
                needle.y             = cluster.startFlag==true? 44:64 //92
                rpm_inactive.x       = cluster.startFlag==true? -175:-30
                rpm_inactive.y       = cluster.startFlag==true? 18:20
                rpm_inactive.scale   = cluster.startFlag==true? 1.4:1

                speed_active.opacity = cluster.startFlag==true? 0:0
                needle1.x            = cluster.startFlag==true? 311:127 //314:129
                needle1.y            = cluster.startFlag==true? 52:72 //95
                speed_inactive.x     = cluster.startFlag==true? 166:-9
                speed_inactive.y     = cluster.startFlag==true? 26:28
                speed_inactive.scale = cluster.startFlag==true? 1.4:1


                break;
            case 1:
                cluster.configurableDial="image/rpm_inactive.png"
                cluster.configurableDial_index = 2

                rpm_active.opacity   = cluster.startFlag==true? 1:0
                needle.x             = cluster.startFlag==true?-77:102
                needle.y             = cluster.startFlag==true? 54:84
                rpm_inactive.x       = cluster.startFlag==true? -205:-30
                rpm_inactive.y       = cluster.startFlag==true? -10:20
                rpm_inactive.scale   = cluster.startFlag==true? 1.2:1

                speed_active.opacity = cluster.startFlag==true? 1:0
                needle1.x            = cluster.startFlag==true? 319:124
                needle1.y            = cluster.startFlag==true? 61:91
                speed_inactive.x     = cluster.startFlag==true? 186:-9
                speed_inactive.y     = cluster.startFlag==true? -2:28
                speed_inactive.scale = cluster.startFlag==true? 1.2:1
                break;
            case 2:
                cluster.configurableDial="image/original Speedo.png"
                cluster.configurableDial_index = 3

                rpm_active.opacity   = cluster.startFlag==true? 0:0
                needle.x             = cluster.startFlag==true?-84:91
                needle.y             = cluster.startFlag==true? 50:82
                rpm_inactive.x       = cluster.startFlag==true? -205:-30  //-205:-30
                rpm_inactive.y       = cluster.startFlag==true? -10:20
                rpm_inactive.scale   = cluster.startFlag==true? 1.2:1

                speed_active.opacity = cluster.startFlag==true? 0:0
                needle1.x            = cluster.startFlag==true? 307:112
                needle1.y            = cluster.startFlag==true? 60:90
                speed_inactive.x     = cluster.startFlag==true? 186:-9
                speed_inactive.y     = cluster.startFlag==true? -2:28
                speed_inactive.scale = cluster.startFlag==true? 1.2:1
                break;

            case 3:

                break;
            }
        }

    }

    states: State {
        name: "active"; when: delDial.activeFocus
        PropertyChanges { target: dialRec; color: "white"; scale: 1.1 }

    }

    transitions: Transition {
        NumberAnimation { properties: "scale"; duration: 100 }
    }
}
