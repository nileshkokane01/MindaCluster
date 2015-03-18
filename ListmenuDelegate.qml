import QtQuick 2.1

Item {
    id: container
    width: 150; height:50; anchors.margins:5
    property bool raiseFlag

    Rectangle {
        id: content
        anchors.centerIn: parent; width:140; height:30;
        color: "transparent"
        antialiasing: true
        anchors.margins:3
        radius: 10


        Rectangle { anchors.fill: parent; anchors.margins:3; color: "#eae70f"; antialiasing: true; radius: 8 }
    }

    Text {
        id: label
        anchors.centerIn: content
        text: modelData
        color: "#193441"
        font.pixelSize: 14
    }

    Keys.onReturnPressed:
      { cluster.navigation_step += 1;
        if(cluster.navigation_step==3){
         switch(index){
         case 0:
             viewBackgroundoption.focus=true
             break;
         case 1:
             viewPointeroption.focus=true
             break;
         case 2:
             viewDialoption.focus=true
             break;
         case 3:           
             viewCalendaroption.focus=true
             break;
         case 4:
             cluster.navigation_step=2
             break;
         case 5:
             cluster.navigation_step=2
             break;
         case 6:
             cluster.dummySerialselect=false
             cluster.navigation_step=2
             break;
         case 7:
             cluster.dummySerialselect=true
             cluster.navigation_step=2
             break;
         }
        }
     }


   states: State {
        name: "active"; when: container.activeFocus
        PropertyChanges { target: content; color: "#FCFFF5"; scale: 1.1 }
        PropertyChanges { target: label; font.pixelSize: 16 }
    }

    transitions: Transition {
        NumberAnimation { properties: "scale"; duration: 100 }
    }
}
