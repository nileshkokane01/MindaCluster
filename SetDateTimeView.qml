import QtQuick 2.0

Item{
    id: cal
    width:200
    height:200

    property int selectTAB:1

    Rectangle {
        id: dateTimeRec
        anchors.centerIn: parent; width: 115; height: 145
        color: "wheat"
        antialiasing: true
        radius: 10
        //      Rectangle { anchors.fill: parent; anchors.margins: 3; color: "#0d0f11"; antialiasing: true; radius: 8 }
        Rectangle {
            id:dateSet
            //            anchors.centerIn: dateTimeRec
            x:10; y:3
            width: dateTimeRec.width - 20; height: childrenRect.height//dateTimeRec.height - 130
            anchors.leftMargin: 3; border.color: "#d1571a";
            color: "#6fbb84"; antialiasing: true; radius: 9
            opacity:1

            Text {
                id: contenttxt
                // x:68; y:5
                anchors.centerIn: dateSet
                color: "#0f28a4"
                font.pixelSize: 15
                font.bold: true; font.underline: true
                text: qsTr("DATE")
                styleColor: "#9cd8ea"
                opacity:1
            }
        }

        Rectangle {
            id:timeSet
            //anchors.centerIn: dateTimeRec.horizontalCenter
            x:10;
            y:78
            width: dateTimeRec.width - 20; height: childrenRect.height//dateTimeRec.height - 130
            anchors.leftMargin: 3; border.color: "#d1571a"
            color: "#6fbb84"; antialiasing: true; radius: 9
            opacity:1

            Text {
                id: contenttxt2
                //x:70; y: 80
                anchors.centerIn: timeSet
                color: "#0f28a4"
                font.pixelSize: 15
                font.bold: true; font.underline: true
                text: qsTr("TIME")
                opacity:1
            }
        }
        Rectangle {
            id:smallHighlighter
            x:14;
            y:37
            width: 22; height: 20
            color: "#e84470"; opacity: 0
        }
        Rectangle {
            id:largeHighlighter
            x:56;
            y:37
            width: 46; height: 20
            color: "#e84470"; opacity: 0
        }

        Text {
            id: contenttxt1
            x:11;
            //anchors.centerIn: dateTimeRec
            y: 38
            color: "#084d26"
            font.pixelSize: 15
            font.bold: true;
            text: Qt.formatDate(new Date(cluster.setYY,cluster.setMM-1,cluster.setDD,'','',''),"dd.MM.yyyy")//cal.setDD+':'+cal.setMM+':'+cal.setYY
            opacity:1
        }

        Text {
            id: contenttxt3
            x:22;
            //anchors.centerIn: dateTimeRec
            y: 112
            color: "#084d26"
            font.pixelSize: 15
            font.bold: true;
            text: Qt.formatTime(new Date('','','',cluster.setHH,cluster.setMN,cluster.setSS),"hh:mm:ss") //cal.setHH + ':' + cal.setMN + ':' + cal.setSS
            opacity:1
        }
    }

    focus: true
    Keys.onPressed: {
        if (event.key === Qt.Key_Return) {
            cluster.days=cluster.setDD; cluster.month=cluster.setMM; cluster.year=cluster.setYY
            cluster.hr=cluster.setHH; cluster.min= cluster.setMN; cal.selectTAB=1
            viewCalendaroption.focus =true
            viewDateTimeoption.focus =false
        }


        if (event.key === Qt.Key_Up) {
            if(++cal.selectTAB>6)
                cal.selectTAB=1;

            switch(cal.selectTAB)
            {
            case 1: dateSet.color="#6fbb84"; timeSet.color="#6fbb84"
                smallHighlighter.opacity=0; largeHighlighter.opacity=0; break

            case 2: dateSet.color="#457812"; timeSet.color="#6fbb84"
                smallHighlighter.x=10; smallHighlighter.y=37
                smallHighlighter.opacity=0.75; largeHighlighter.opacity=0; break

            case 3: smallHighlighter.x=36; smallHighlighter.y=37
                smallHighlighter.opacity=0.75; largeHighlighter.opacity=0; break

            case 4: largeHighlighter.x=62; largeHighlighter.y=37
                smallHighlighter.opacity=0; largeHighlighter.opacity=0.75; break

            case 5: dateSet.color="#6fbb84"; timeSet.color="#457812"
                smallHighlighter.x=21; smallHighlighter.y=111
                smallHighlighter.opacity=0.75; largeHighlighter.opacity=0; break

            case 6: smallHighlighter.x=48; smallHighlighter.y=111
                smallHighlighter.opacity=0.75; largeHighlighter.opacity=0; break

            default:dateSet.color="#6fbb84"; timeSet.color="#6fbb84"
                smallHighlighter.opacity=0; largeHighlighter.opacity=0;
            }
        }
        if (event.key === Qt.Key_Right) {
            switch(cal.selectTAB)
            {
            case 1: break

            case 2: if ((++cluster.setDD ==29 && cluster.setMM===2 && (cluster.setYY%4 !== 0)) || (cluster.setDD === 30 && cluster.setMM===2)|| (cluster.setDD === 31 && (cluster.setMM===4 || cluster.setMM===6 || cluster.setMM===9 || cluster.setMM===11))||(cluster.setDD === 32))
                { cluster.setDD=1} break

            case 3: if (++cluster.setMM === 13)
                { cluster.setMM=1} break

            case 4: if (++cluster.setYY === 2100)
                { cluster.setYY=2000} break

            case 5: if (++cluster.setHH >23)
                { cluster.setHH=0} break

            case 6: if (++cluster.setMN >59)
                { cluster.setMN=0} break

            default: break
            }
        }
        if (event.key === Qt.Key_Left) {
            switch(cal.selectTAB)
            {
            case 1: break

            case 2: if (--cluster.setDD ===0)
                { cluster.setDD=1} break

            case 3: if (--cluster.setMM === 0)
                { cluster.setMM=12} break

            case 4: if (--cluster.setYY === 1999)
                { cluster.setYY=2099} break

            case 5: if (--cluster.setHH <0)
                { cluster.setHH=23} break

            case 6: if (--cluster.setMN <0)
                { cluster.setMN=59} break

            default: break
            }
        }
    }
}

