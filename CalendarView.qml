import QtQuick 2.0
import QtQuick.Controls 1.1

Item{
    id: cal
    width:300
    height:300
    property int tabSelect:1
    Rectangle {
        id: calendar
        anchors.centerIn: parent
        width:250
        height:250
        color: "#9f94ca"
        border.color: "#8f107e"
        border.width: 2
        focus:true

        radius: 10
        property int dow;

        function isLeapYear(yy)
        {
            return ((yy%4==0)&&((yy%100!=0)||(yy%400==0)));
        }

        function firstDayOfWeek (mm, yy)
        {
            var i
            dow=0;
            for(i=1583;i<yy;i++)
                dow+=(isLeapYear(i)? 2:1);
            for(i=1;i<mm;i++)
                dow+=calDaysInMonth(i,yy);

            dow=dow % 7;
            if(dow==0)
            {
                dow=7
            }

            return (dow-1)//(dow % 7)-1
        }

        function calDaysInMonth(mm,yy)
        {
            switch(mm)
            {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12: return 31;
            case 2:  if(isLeapYear(yy))
                    return 29;
                else
                    return 28;
            default: return 30;
            }
        }

        property real today_year: cluster.year//new Date()
        property var showDate: cluster.day//new Date()
        property int daysInMonth: calDaysInMonth(cluster.month,cluster.year)//new Date(showDate.getFullYear(), showDate.getMonth() + 1, 0).getDate()
        property int firstDay: firstDayOfWeek(cluster.month,cluster.year)//new Date(showDate.getFullYear(), showDate.getMonth(), 1).getDay()
        property var arrMonths: ["January","February","March","April","May","June","July","August","September","October","November","December"]

        Item {
            id:title
            anchors.top: parent.top
            anchors.topMargin: 5
            width: parent.width
            height: childrenRect.height

            Image {
                id:monthright
                source: "image/navigation_previous_item.png"
                scale: 0.5
                anchors.left: parent.left
                anchors.leftMargin: -10
            }

            Rectangle{
                id: rectMonth
                width: parent.width/3+10
                height:15// childrenRect.height
                color: "#a777e6"
                border.color: {
                    if (tabSelect===false)
                        border.color="#6f0707"
                    else
                        border.color="transparent"
                }
                border.width: 2
                x:20;
                y:13

                Text {
                    id:month
                    x:45;
                    //                    y:10
                    color: "#381313"
                    font.family: "Courier 10 Pitch"
                    text: calendar.arrMonths[cluster.month-1]//Qt.formatDateTime(showDate, "MMMM")
                    font.bold: true
                    font.pointSize: 12
                    opacity: 1
                    anchors.centerIn: rectMonth
                    anchors.margins: 5
                }
            }

            Image {
                source: "image/navigation_next_item.png"
                scale: 0.5
                anchors.left:rectMonth.right
                anchors.leftMargin: -20
            }
            Image {
                source: "image/navigation_previous_item.png"
                scale: 0.5
                anchors.right: rectyear.left
                anchors.rightMargin: -18
            }
            Rectangle{
                id: rectyear
                width: parent.width/6
                height: 15//childrenRect.height
                color: "#a777e6"
                border.color: {
                    if (tabSelect===true)
                        border.color="#6f0707"
                    else
                        border.color="transparent"
                }
                border.width: 2
                x:181;y:12

                Text {
                    id:yearleft
                    //                    x:255
                    //                    y:10
                    color: "#381313"
                    font.family: "Courier 10 Pitch"
                    text: cluster.year//Qt.formatDateTime(showDate, "yyyy")
                    font.bold: true
                    font.pointSize: 12
                    opacity: 1
                    anchors.centerIn: rectyear
                }
            }

            Image {
                id:year
                source: "image/navigation_next_item.png"
                scale: 0.5
                anchors.right: parent.right
                anchors.rightMargin: -3
            }
        }


        Item {
            id: dateLabels
            anchors.top: title.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: -1
            anchors.margins: 10

            height: calendar.height - title.height - 60 - title.anchors.topMargin
            property int rows: 6
            Item {
                id: dayLabels
                width: parent.width
                height: childrenRect.height

                Grid {
                    columns: 7
                    spacing: 10

                    Repeater {
                        model: ["SUN","MON","TUE","WED","THU","FRI","SAT"]//7

                        Rectangle {
                            color: "transparent"
                            //border.color: "#991243"
                            width: (calendar.width - 20 - 60)/7
                            height: childrenRect.height-2
                            Text {
                                color: "#381313"    //#a0cc31
                                // Qt dates (for formatting) and JavaScript dates use different ranges
                                // (1-7 and 0-6 respectively), so we add 1 to the day number.
                                text: modelData
                                font.family: "Courier 10 Pitch"
                                font.bold: true
                                styleColor: "#a777e6"   //#991243
                                font.pointSize: 11
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }
            }

            Item {
                id: dateGrid
                width: parent.width
                anchors.top: dayLabels.bottom
                anchors.topMargin: 5
                anchors.bottom: parent.bottom//setdateTime.top

                Grid {
                    columns: 7
                    rows: dateLabels.rows
                    spacing: 10

                    Repeater {
                        id: dateRepeat
                        model: calendar.firstDay + calendar.daysInMonth

                        Rectangle {
                            // border.color: "#991243"
                            color: {
                                if (index < calendar.firstDay)
                                {
                                    calendar.color="#9f94ca";
                                    border.color="transparent"
                                }
                                else
                                {
                                    if((index-calendar.firstDay)===(cluster.days-1))  //(isToday(index-calendar.firstDay))
                                        color="yellow";
                                    else
                                        color="transparent"
                                }
                            }

                            width: (calendar.width - 20 - 60)/7
                            height: (dateGrid.height - (dateLabels.rows - 1)*10)/dateLabels.rows + 2

                            Text {
                                anchors.centerIn: parent
                                text: index - calendar.firstDay+1
                                opacity: (index < calendar.firstDay) ? 0 : 1
                                font.family: "Courier 10 Pitch"
                                font.bold:((index-calendar.firstDay)===cluster.days-1)?true:false//isToday(index - calendar.firstDay)?false:true
                                font.pointSize: 10
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: rect_DateTime
            x:7

            width: parent.width/2
            height: 15//childrenRect.height
            anchors.top: dateLabels.bottom
            //                        anchors.left: calender.left
            anchors.topMargin: 22
            color: "#a777e6"//#eeeeee
            radius: 5
            border.width: 2
            border.color: "transparent"

            Text {
                anchors.centerIn: rect_DateTime
                text: "Set Date/Time"
                font.family: "Courier 10 Pitch"
                font.bold: true
                font.pointSize: 11
                color: "#381313"
            }
        }

        Rectangle {
            id: rectTime
            x:162
            width: parent.width/4+15
            height: 15//childrenRect.height
            anchors.top: dateLabels.bottom
            //                        anchors.left: calender.left
            anchors.topMargin: 22
            color: "#a777e6"//#eeeeee
            radius: 5
            //                        border.width: 2
            //                        border.color: "#6f0707"

            Text {
                anchors.centerIn: rectTime
                font.family: "Courier 10 Pitch"
                font.bold: true
                font.pointSize: 12
                color: "#381313"
                text: Qt.formatTime(new Date('','','',cluster.hr,cluster.min,cluster.sec),"hh:mm:ss")   //cluster.hr +":"+ cluster.min +":"+ cluster.sec
            }
        }
    }

    focus: true
    Keys.onPressed: {
        if (event.key === Qt.Key_Left) {

            switch(tabSelect)
            {
            case 1: break

            case 2: if (--cluster.month === 0)
                { cluster.year--; cluster.month=12} break

            case 3: if(--cluster.year === 1999)
                { cluster.year=2099} break

            case 4: break
            }

        }
        if (event.key === Qt.Key_Right) {

            switch(tabSelect)
            {
            case 1: break

            case 2: if (++cluster.month === 13)
                { cluster.year++; cluster.month=1} break

            case 3: if(++cluster.year === 2100)
                { cluster.year=2000} break

            case 4: break
            }

        }
        if (event.key === Qt.Key_Up) {
            if(++tabSelect>4)
                tabSelect=1
            switch(tabSelect)
            {
            case 1: rectyear.border.color="transparent"; rectMonth.border.color="transparent"
                rect_DateTime.border.color="transparent"; break

            case 2: rectyear.border.color="transparent"; rectMonth.border.color="#6f0707"
                rect_DateTime.border.color="transparent"; break

            case 3: rectyear.border.color="#6f0707"; rectMonth.border.color="transparent"
                rect_DateTime.border.color="transparent"; break

            case 4: rectyear.border.color="transparent";  rectMonth.border.color="transparent"
                rect_DateTime.border.color="#6f0707"; break

            default: break
            }

        }
        if (event.key === Qt.Key_Return) {

            if(tabSelect===4)
            {
                cluster.setDD=cluster.days; cluster.setMM=cluster.month; cluster.setYY=cluster.year
                cluster.setHH=cluster.hr; cluster.setMN=cluster.min;
                viewCalendaroption.focus =false
                viewDateTimeoption.focus=true
            }
        }

        if (event.key === Qt.Key_Escape) {

            listmenu.focus=true
            cluster.menu = 0
            cluster.navigation_step=3
            viewCalendaroption.focus =false
            viewDateTimeoption.focus=false
        }



    }


}


