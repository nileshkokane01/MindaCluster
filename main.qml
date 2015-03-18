import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.1
import CircleGraph 1.0
import serial 1.0


ApplicationWindow {
    visible: true
    width: 1280
    height: 480
    //    visibility:Window.FullScreen

    Rectangle {
        id: cluster
        width:1280; height: 480;
        color: switch(cluster.configurableBackground_index){case 1:"white";break;case 13:"black";break;default:"black"}

        property int hr: 10
        property int min: 59
        property int sec:20
        property int month:12
        property int days:12
        property int year:2015

        property int setDD: 0 //cluster.days
        property int setMM: 0//cluster.month
        property int setYY: 0//cluster.year
        property int setHH: 0//cluster.hr
        property int setMN: 0//cluster.min
        property int setSS: 0//cluster.sec
        property bool startFlag: false
        property bool menuFlag: true
        property bool startStopEnable: false
        property int  startStop: 0
        property int  menu: 0
        property bool startStopActive: false
        property bool flipped: false
        property int  navigation_step:0
        property real dialOpacity : 0
        property real rpmValue: 0
        property real speedValue: 0
        property int  gear: 0
        property int  fuelValue: 30
        property int  fuelDummy:30
        property int  tempDummy:0

        property bool turn_rightFlag: false
        property bool turn_leftFlag: false
        property bool beamFlag: false
        property bool oilFlag: false
        property bool batteryFlag: false
        property bool fuelFlag: false
        property bool parkingFlag: false
        property bool brakeFlag: false


        property string configurablePointer:"image/Pointer5.png"
        property string configurableBackground:""//"image/Skin_4.png"
        property string configurableDial:"image/original Speedo.png"
        property int configurableDial_index:3
        property int skin_3_configurableDial_index:1
        property int skin_9_configurableDial_index:1
        property int skin_Blank_configurableDial_index:1
        property string skin_9_configurablePointer:"image/Skin_9_RPM_Pointer1.png"
        property string skin_12_configurablePointer:"image/Skin_9_RPM_Pointer1.png"
        property int skin_12_configurablePointer_index:1
        property int configurableBackground_index: 9
        property bool dummySerialselect:true




        function rpmSpeedMeter(){

            if(dummySerialselect==false){
                rpmMeter.value1=w.rpmData
                speedoMeter.value = w.speedData
            }

            else{
                rpmMeter.value1 = rpmValue
                speedoMeter.value = speedValue
            }


            switch(gear)
            {
            case 0:
                rpmValue = rpmValue + 5
                speedValue = speedValue + 2
                gear = 1
                bounce_gear_image.start()
                bounce_display_gear.start()
                break;
            case 1:
                if(rpmValue > 60)
                {
                    rpmValue = 30;
                    speedValue = speedValue - 5
                    gear = 2
                    bounce_gear_image.start()
                    bounce_display_gear.start()
                }
                rpmValue = rpmValue + 2.5
                speedValue = speedValue + 1.5
                break;

            case 2:
                if(rpmValue > 70)
                {
                    rpmValue = 50;
                    speedValue = speedValue - 4
                    gear = 3
                    bounce_gear_image.start()
                    bounce_display_gear.start()
                }
                rpmValue = rpmValue + 2
                speedValue = speedValue + 1


                break;
            case 3:
                if(rpmValue > 80)
                {
                    rpmValue = 60;
                    speedValue = speedValue - 3
                    gear = 4
                    bounce_gear_image.start()
                    bounce_display_gear.start()
                }
                rpmValue = rpmValue + 1.5
                speedValue = speedValue + 0.8

                break;
            case 4:
                if(rpmValue > 90)
                {
                    rpmValue = 70;
                    speedValue = speedValue - 1
                    gear = 4
                }
                rpmValue = rpmValue + 1
                speedValue = speedValue + 1.2
                break;

            }
            if(speedValue >120 && configurableBackground_index !=9)
            {
                rpmValue = speedValue = gear = 0
                bounce_gear_image.start()
                bounce_display_gear.start()
            }
            if(configurableBackground_index ==9 && speedValue >180  )
            {
                rpmValue = speedValue = gear = 0
                bounce_gear_image.start()
                bounce_display_gear.start()
            }

        }

        Timer {
            id:rpmAndspeedUpdate
            interval: 200
            running: false
            repeat: true
            onTriggered: {
                if(cluster.startFlag == true)
                    cluster.rpmSpeedMeter()
                else{rpmMeter.value1=0;speedoMeter.value=0;}
            }
        }

        Item{
            id:all_telltales
            z:1
            opacity:switch(cluster.configurableBackground_index){case 3:0;break;case 4:0;break;case 9:0;break;case 12:0;break;case 13:0;break;default:1}
            Image {
                id: music_icon
                x: 150
                y: 400
                z: 1
                scale: 0.5
                //rotation: 90
                opacity: 0
                //clip: true
                //smooth: true
                source: "image/Music icon.png"



            }

            Image {
                id: stop_engine
                x: 345
                y: 2
                z: 1
                scale: 0.35
                opacity: 0.05
                //visible: true
                source: "image/stop_engine.png"
            }
            Image {
                id: water_in_fuel
                x: 425
                y: 10
                z: 1
                scale: 0.4
                opacity: 0.05
                //visible: true
                source: "image/water_in_fuel.png"
            }
            Image {
                id: low_aux_air
                x: 80
                y: 60
                z: 1
                scale: 0.4
                opacity: 0.05
                //visible: true
                source: "image/low_aux_air.png"
            }
            Image {
                id: batt_col
                x: 160
                y: 60
                z: 1
                scale: 0.4
                opacity: 0.05
                //rotation: 90
                source: "image/Batt col.png"
            }


            Image {
                id: highbeam
                x: 230
                y: 65
                z: 1
                scale: 0.4
                opacity: 0.05
                //rotation: 90
                source: "image/Highbeam.png"
            }

            Image {
                id: setbelt_col
                x: 290
                y: 45
                z: 1
                scale: 0.38
                opacity: 0.05
                source: "image/setbelt col.png"
                //Behavior on x { SpringAnimation { spring: 2; damping: 0.2 } }
                //Behavior on y { SpringAnimation { spring: 2; damping: 0.2 } }

            }
            /*MouseArea {
                   anchors.fill: parent
                   onClicked: {
                                 setbelt_col.x = mouse.x - setbelt_col.width/2
                                 setbelt_col.y = mouse.y - setbelt_col.height/2
                              }
                   } */

            Image {
                id: trans_1
                x: 350
                y: 40
                z: 1
                scale: 0.35
                opacity: 0.08
                //visible: true
                source: "image/trans_1.png"
            }

            Image {
                id: dc_dc_fail
                x: 420
                y: 65
                z: 1
                scale: 0.4
                opacity: 0.08
                //visible: true
                source: "image/dc_dc_fail.png"
            }

            Image {
                id: rear_fog
                x: 480
                y: 65
                z: 1
                scale: 0.3
                opacity: 0.05
                //visible: true
                source: "image/rear_fog.png"
            }

            Image {
                id: low_oil
                x: 540
                y: 92
                z: 1
                scale: 0.45
                opacity: 0.05
                //visible: true
                source: "image/low_oil.png"
                //transform: Rotation { origin.x: 5; origin.y: 5; axis { x: 0; y: 1; z: 0 } angle: 50 }
            }

            Image {
                id: filter
                x: 620
                y: 80
                z: 1
                scale: 0.39
                opacity: 0.04
                //visible: true
                source: "image/filter.png"
            }
            Image {
                id: glow_plug
                x: 675
                y: 92
                z: 1
                scale: 0.4
                opacity: 0.04
                //visible: true
                source: "image/glow_plug.png"
            }
            Image {
                id: logo
                x: 530
                y: 25
                z: 1
                scale: 0.8
                opacity:switch(cluster.configurableBackground_index){case 9:0;break;case 12:0;break;default:1}
                //rotation: 90
                source:"image/logo.png"
            }



            Image {
                id: parking_light
                x: 540
                y: 92
                z: 1
                scale: 0.45
                opacity: 0
                //visible: true
                source: "image/PARKING.png"
            }
            Image {
                id: brakefailure
                x: 540
                y: 92
                z: 1
                scale: 0.45
                opacity: 0
                //visible: true
                source: "image/Brake_failure.png"
            }

            Image {
                id: turn_left
                x: 560
                y: 208
                smooth: true
                opacity:switch(cluster.configurableBackground_index){case 12:0;break;default:0.05}
                z: 3
                source: "image/turn_indicator_left.png"
            }

            Image {
                id: turn_right
                x: 660
                y: 208
                smooth: true
                opacity:switch(cluster.configurableBackground_index){case 12:0;break;default:0.05}
                z: 3
                source: "image/turn_indicator.png"
            }
            Image {
                id: cabin_lock
                x: 750
                y: 7
                z: 1
                scale: 0.45
                opacity: 0.05
                //visible: true
                source: "image/cabin_lock.png"

            }
            Image {
                id: exhaust
                x: 810
                y: 0
                z: 1
                scale: 0.35
                opacity: 0.05
                //visible: true
                source: "image/exhaust.png"
            }

            Image {
                id: petrol_indicator
                x: 740
                y: 38
                z: 1
                scale: 0.3
                opacity: 0.04
                source: "image/petrol.png"
            }

            Image {
                id: battery_low
                x: 820
                y: 60
                z: 1
                scale: 0.4
                opacity: 0.03
                //rotation: 90
                source: "image/battery_low.png"
            }

            Image {
                id: temp
                x: 870
                y: 60
                z: 1
                scale: 0.4
                opacity: 0.05
                //rotation: 90
                source: "image/Temp_Col.png"
            }

            Image {
                id: oilIndication
                x: 950
                y: 80
                z: 1
                scale: 0.7
                opacity: 0.03
                source: "image/oilIndicator.png"
            }

            Image {
                id: engine_check
                x: 1000
                y: 58
                z: 1
                scale: 0.38
                opacity: 0.05
                //visible: true
                source: "image/engine_check.png"
            }

            Image {
                id: immobilizer
                x: 1080
                y: 60
                z: 1
                scale: 0.4
                opacity: 0.05
                //visible: true
                source: "image/immobilizer.png"
            }
        }

        Image{
            id:backGround
            anchors.fill:parent

            z:0
            //scale:0.95
            source:cluster.configurableBackground
        }



        Image {
            id: rpm_active
            x: 241
            y: 99
            z: 3
            opacity: 0
            visible: true
            source: "image/rpm_active.png"
        }

        Image {
            id: speed_active
            x: 695
            y: 95
            z:  3
            opacity: 0
            visible: true
            source: "image/speed_active1.png"
        }

        /**/
        Text {
            id: digitalSpeed
            x: switch(cluster.configurableBackground_index){case 9:if(speedoMeter.value<10){642}else if(9<speedoMeter.value<100){622}if(speedoMeter.value>99){602};break;default:840}
            y: switch(cluster.configurableBackground_index){case 9:180;break;default:880}
            z: 3
            //anchors.centerIn: cluster.Center
            //horizontalAlignment: Text.AlignHCenter
            //anchors.verticalCenter: skin_9_Speed_dail.verticalCenter
            color: "#cde81d"
            text: parseInt(speedoMeter.value)
            font.family: "URW Chancery L"
            //font.family: switch(cluster.configurableBackground_index){case 9:"URW Chancery L";break;default:"Abyssinica SIL"}

            smooth: true
            opacity: 0 //switch(cluster.configurableBackground_index){case 2:0;break;case 3:0;break;case 4:0;break;case 5:0;break;case 9:0;break;case 12:0;break;default:switch(cluster.configurableDial_index){case 1:0;break;case 2:1;break;}}
            style: Text.Raised
            font.pixelSize: switch(cluster.configurableBackground_index){case 9:80;break;default:35}

        }


        Image {
            id: neutral
            x: switch(cluster.configurableBackground_index){case 3:625;break;case 9:630;break;case 12:625;break;case 13:625;break;default:598}
            y: switch(cluster.configurableBackground_index){case 9:145;break;case 12:142;break;default:135}
            z: 1
            scale: 0.4
            opacity:0 //switch(cluster.configurableBackground_index){case 3:0;break;case 9:0;break;case 12:0;break;default:1}
            //visible: true
            source: "image/neutral.png"
        }
        Text {
            id: display_gear
            property int maxHeight: 110 //160 //cluster.height / 3
            property int minHeight: 137 //320 //2 * cluster.height / 3
            x: switch(cluster.configurableBackground_index){case 3:645;break;case 9:662;break;case 12:645;break;case 13:645;break;default:620}
            y: 137
            z: 4
            color: "#92ea45" //"#ee0ed0"
            text: parseInt(cluster.gear)
            font.family: "Abyssinica SIL"
            horizontalAlignment: Text.AlignHCenter
            smooth: true
            opacity: 0
            style: Text.Raised
            font.pixelSize: 30

            SequentialAnimation on y {
                id: bounce_display_gear

                NumberAnimation {
                    from: display_gear.minHeight; to: display_gear.maxHeight
                    easing.type: Easing.OutExpo; duration: 300
                }

                // Then move back to minHeight in 1 second, using the OutBounce easing function
                NumberAnimation {
                    from: display_gear.maxHeight; to: display_gear.minHeight
                    easing.type: Easing.OutBounce; duration: 1000
                }
                // Then pause for 500ms
                PauseAnimation { duration: 500 }
            }
        }

        Image {
            id: gear_image
            property int maxHeight: 5 //80 //160 //cluster.height / 3
            property int minHeight: 28 //110 //320 //2 * cluster.height / 3

            //anchors.horizontalCenter: parent.horizontalCenter
            x: switch(cluster.configurableBackground_index){case 3:523;break;case 9:540;break;case 12:523;break;case 13:523;break;default:498} //568
            y: 28 //minHeight
            z: 3
            scale:0.2
            opacity:0
            source: "image/settings.png"

            //transform: Rotation{angle:{30}}

            SequentialAnimation on y {
                id: bounce_gear_image
                //loops: Animation.Infinite
                // Move from minHeight to maxHeight in 300ms, using the OutExpo easing function
                NumberAnimation {
                    from: gear_image.minHeight; to: gear_image.maxHeight
                    easing.type: Easing.OutExpo; duration: 300
                }


                // Then move back to minHeight in 1 second, using the OutBounce easing function
                NumberAnimation {
                    from: gear_image.maxHeight; to: gear_image.minHeight
                    easing.type: Easing.OutBounce; duration: 1000
                }
                // Then pause for 500ms
                PauseAnimation { duration: 500 }
            }

        }
        Text {
            id: totalDistance
            x: 563
            y: 131
            color: "#a5bcc6"
            text: "Distance:"
            smooth: true
            opacity: 0
            style: Text.Raised
            font.bold: true
            z: 0
            font.pixelSize: 15
        }



        Text {
            id: destination
            x: 363
            y: 0
            color: "#a5bcc6"
            text: "Destination: Time Square, NY"
            font.family: "DejaVu Sans"
            font.bold: true
            smooth: true
            opacity: 0
            style: Text.Raised
            font.pixelSize:15
            z: 0
        }


        Text {
            id: time
            x: 363
            y: 131
            color: "#a5bcc6"
            text: "Time: 12:45:07"
            smooth: true
            opacity:0
            style: Text.Raised
            font.pixelSize: 15
            font.bold: true
            z: 0
        }

        Timer{
            id: timer
            interval: 1000
            repeat: true
            running: true

            onTriggered:
            {
                if((++cluster.sec) > 59)                        // seconds counter
                {
                    cluster.sec=0;
                    //                   cluster.updateTime=True;
                    if((++cluster.min) > 59)                   // minits counter
                    {
                        cluster.min=0;
                        if((++cluster.hr) > 23) 				  // hours counter
                        {
                            cluster.hr=0;
                            //                          cluster.updateDate=True;
                            if ((++cluster.days ==29 && cluster.month===2 && (cluster.year%4 !== 0)) || (cluster.days === 30 && cluster.month===2)|| (cluster.days === 31 && (cluster.month===4 || cluster.month===6 || cluster.month===9 || cluster.month===11))||(cluster.days === 32))
                            {
                                cluster.month++; cluster.days=1;
                            }
                            if (cluster.month === 13)
                            {
                                cluster.year++; cluster.month=1;
                            }

                        }
                    }
                }
                time.text = "Time: "+ Qt.formatTime(new Date('','','',cluster.hr,cluster.min,cluster.sec),"hh:mm:ss")//"Time: "+ cluster.hr +":"+ cluster.min +":"+ cluster.sec //cluster.time_Str //qsTr("Time: ")+
                date.text = "Date: "+ Qt.formatDate(new Date(cluster.year,cluster.month-1,cluster.days,'','',''),"dd.MM.yyyy")//cluster.days +"-"+ cluster.month +"-"+ cluster.year
                totalDistance.text="Distance:" + cluster.min
            }
        }
        Text {
            id: date
            x: 363
            y: 131
            text: "Date: "
            smooth: true
            color: "#a5bcc6"
            opacity:0
            style: Text.Raised
            font.pixelSize: 15
            font.bold: true
            z: 0
        }

        Text {
            id: oil
            x: 570
            y: 200
            color: "#e61414"
            text: "Engine Oil Low Level"
            smooth: true
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: false
            font.pixelSize: 15
        }

        Text {
            id: brake
            x: 570
            y: 200
            color: "#f52323"
            text: "Brake Pad Warning"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            visible: false
            font.pixelSize: 15
        }

        Text {
            id: fuelLeak
            x: 540
            y: 200
            color: "#c70a0a"
            text: "Fuel Tank Leakage Warning"
            smooth: true
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: false
            font.pixelSize: 15
        }

        Text {
            id: battery
            x: 590
            y: 200
            color: "#f21616"
            text: "Battery Low"
            smooth: true
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: false
            font.pixelSize: 15
        }

        Text {
            id:parkinglight
            x: 580
            y: 200
            color: "#f21616"
            text: "Parking Light ON"
            smooth: true
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: false
            font.pixelSize:15
        }

        Text {
            id:highBeam
            x: 580
            y: 200
            color: "#e61414"
            text: "High Beam On"
            smooth: true
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: false
            font.pixelSize: 15
        }

        Text {
            id: turnright
            x: 585
            y: 220
            color: "#f21616"
            text: "Right Turn"
            smooth: true
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: false
            font.pixelSize: 15
        }

        Text {
            id: turnleft
            x: 595
            y: 220
            color: "#f21616"
            text: "Turn Left"
            smooth: true
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: false
            font.pixelSize: 15
        }



        Item{
            id:skin_9
            scale:0.8
            x:130; y:60
            Image {
                id: skin_9_RPM_dail
                x: 190 //290
                y: 103
                //anchors.horizontalCenter: cluster.horizontalCenter+100
                //anchors.verticalCenter: cluster.verticalCenter
                z: 1
                scale:1 //0.50
                opacity: switch(cluster.configurableBackground_index){case 9:1;break;default:0}
                source: "image/Skin_9_RPM.png"
                states:[
                    State {
                        name: "skin_9_change_RPM_dial1"; when: ((cluster.configurableBackground_index == 9)&&(cluster.skin_9_configurableDial_index == 1))
                        PropertyChanges { target: skin_9_RPM_dail; source:"image/Skin_9_RPM.png"}
                    },
                    State {
                        name: "skin_9_change_RPM_dial2"; when: ((cluster.configurableBackground_index == 9)&&(cluster.skin_9_configurableDial_index == 2))
                        PropertyChanges { target: skin_9_RPM_dail; source:"image/Skin_9_RPM1.png"}
                    },
                    State {
                        name: "skin_9_change_RPM_dial3"; when: ((cluster.configurableBackground_index == 9)&&(cluster.skin_9_configurableDial_index == 3))
                        PropertyChanges { target: skin_9_RPM_dail; source:"image/Skin_9_RPM2.png"}
                    }
                ]

                Rectangle{
                    id :blackPatch_rpm
                    anchors.centerIn: skin_9_RPM_dail
                    height:width
                    width:180
                    z:3
                    radius :width/2
                    color:"black"
                }


                Image {
                    id: skin_9_RPM_pointer
                    y:23
                    anchors.horizontalCenter: parent.horizontalCenter
                    z: 2
                    scale:1
                    opacity: switch(cluster.configurableBackground_index){case 9:1;break;default:0}
                    source: cluster.skin_9_configurablePointer //"image/Skin_9_RPM Pointer.png"

                    transform: Rotation  {
                        id: skin_9_RPM_pointer_Rotation
                        origin.x: 3
                        origin.y: 114
                        angle:{
                            (Math.min(Math.max(-180, rpmMeter.value1*2.2 - 180), 28));
                        }
                        /**/
                        Behavior on angle  {
                            SpringAnimation  {
                                spring: 1.4
                                damping: .15
                            }
                        }
                    }
                }
            }
            Image {
                id: skin_9_Speed_dail
                x: 480
                y: 60
                z: 2
                scale:1 //0.50
                opacity: switch(cluster.configurableBackground_index){case 9:1;break;default:0}
                source: "image/Skin_9_Speedo.png"
                states:[
                    State {
                        name: "skin_9_change_speed_dial1"; when: ((cluster.configurableBackground_index == 9)&&(cluster.skin_9_configurableDial_index == 1))
                        PropertyChanges { target: skin_9_Speed_dail; source:"image/Skin_9_Speedo.png"}
                    },
                    State {
                        name: "skin_9_change_speed_dial2"; when: ((cluster.configurableBackground_index == 9)&&(cluster.skin_9_configurableDial_index == 2))
                        PropertyChanges { target: skin_9_Speed_dail; source:"image/Skin_9_Speedo1.png"}
                    },
                    State {
                        name: "skin_9_change_speed_dial3"; when: ((cluster.configurableBackground_index == 9)&&(cluster.skin_9_configurableDial_index == 3))
                        PropertyChanges { target: skin_9_Speed_dail; source:"image/Skin_9_Speedo2.png"}
                    }
                ]
                Image{
                    id:skin_9_Speedo_Blank_Patch
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    z: 4
                    scale:1
                    opacity: switch(cluster.configurableBackground_index){case 9:1;break;default:0}
                    source: "image/Skin_9_Speedo_Blank_Patch.png"

                }
                Image{
                    id:skin_9_car
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    z: 5
                    scale:0.05
                    opacity: 0 //switch(cluster.configurableBackground_index){case 9:1;break;default:0}
                    source: "image/car.png"

                }

                Image {
                    id: skin_9_Speed_pointer
                    //x: 650
                    y: 47
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.verticalCenter: parent.verticalCenter
                    z: 3
                    scale:1.3
                    opacity: switch(cluster.configurableBackground_index){case 9:1;break;default:0}
                    source: cluster.skin_9_configurablePointer //"image/Skin_9_RPM_Pointer1.png"
                    transform: Rotation  {
                        id: skin_9_Speed_pointer_Rotation
                        origin.x: 3
                        origin.y: 134
                        angle:{
                            (Math.min(Math.max(-125, speedoMeter.value*1.4 - 125), 125));
                        }
                        /**/
                        Behavior on angle  {
                            SpringAnimation  {
                                spring: 1.4
                                damping: .15
                            }
                        }
                    }
                }
            }
            Image {
                id: skin_9_FG_TG_dail
                x: 850 //750
                y: 103
                //anchors.horizontalCenter: cluster.horizontalCenter+100
                //anchors.verticalCenter: cluster.verticalCenter
                z: 1
                scale:1 //0.50
                opacity: switch(cluster.configurableBackground_index){case 9:1;break;default:0}
                source: "image/Skin_9_TG & FG.png"
                states:[
                    State {
                        name: "skin_9_change_FG_TG_dial1"; when: ((cluster.configurableBackground_index == 9)&&(cluster.skin_9_configurableDial_index == 1))
                        PropertyChanges { target: skin_9_FG_TG_dail; source:"image/Skin_9_FG_TG.png"}
                    },
                    State {
                        name: "skin_9_change_FG_TG_dial2"; when: ((cluster.configurableBackground_index == 9)&&(cluster.skin_9_configurableDial_index == 2))
                        PropertyChanges { target: skin_9_FG_TG_dail; source:"image/Skin_9_FG_TG1.png"}
                    },
                    State {
                        name: "skin_9_change_FG_TG_dial3"; when: ((cluster.configurableBackground_index == 9)&&(cluster.skin_9_configurableDial_index == 3))
                        PropertyChanges { target: skin_9_FG_TG_dail; source:"image/Skin_9_FG_TG2.png"}
                    }
                ]
                Image{
                    id:skin_9_Temp_Blank_Patch
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    z: 3
                    scale:1
                    opacity: switch(cluster.configurableBackground_index){case 9:1;break;default:0}
                    source: "image/Skin_9_Temp_Blank_Patch.png"

                }

                Image {
                    id: skin_9_FG_pointer
                    y:24
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.verticalCenter: parent.verticalCenter
                    z: 2
                    scale:1
                    opacity: switch(cluster.configurableBackground_index){case 9:1;break;default:0}
                    source: cluster.skin_9_configurablePointer //"image/Skin_9_Fuel Pointer.png"
                    transform: Rotation  {
                        id: skin_9_FG_pointer_Rotation
                        origin.x: 3
                        origin.y: 114
                        angle:{
                            (Math.min(Math.max(-30, speedoMeter.value*2.6 - 30), 29));
                        }
                        /**/
                        Behavior on angle  {
                            SpringAnimation  {
                                spring: 1.4
                                damping: .15
                            }
                        }
                    }
                }
            }

        }

        Item{
            id:skin_Blank
            //anchors.centerIn: cluster.Center
            x:140
            y:60
            scale: 0.8

            Image {
                id: skin_Blank_RPM_dail
                x: switch(cluster.configurableBackground_index){case 3:570;break;case 9:577;break;}
                y: -100
                //anchors.horizontalCenter: cluster.horizontalCenter+100
                //anchors.verticalCenter: cluster.verticalCenter
                z: 1
                scale:0.50
                opacity: switch(cluster.configurableBackground_index){case 3:1;break;case 12:1;break;case 13:1;break;default:0}
                source: "image/Skin_Blank_RPM_Dial.png"
                states:[
                    State{
                        name: "Skin_Blank_RPM_Dial1"; when: ((cluster.configurableBackground_index == 12)&&(cluster.skin_Blank_configurableDial_index==1)||(cluster.configurableBackground_index == 13))
                        PropertyChanges { target: skin_Blank_RPM_dail; source:"image/Skin_Blank_RPM_Dial.png"}
                    },
                    State{
                        name: "Skin_Blank_RPM_Dial12"; when: ((cluster.configurableBackground_index == 12)&&(cluster.skin_Blank_configurableDial_index==2))
                        PropertyChanges { target: skin_Blank_RPM_dail; source:"image/Skin_Blank_RPM_Dial2.png"}
                    },
                    State{
                        name: "Skin_3_RPM_Dial1"; when: ((cluster.configurableBackground_index == 3)&&(cluster.skin_3_configurableDial_index==1))
                        PropertyChanges { target: skin_Blank_RPM_dail; source:"image/Skin_3_RPM_Dial.png"}
                    },
                    State{
                        name: "Skin_3_RPM_Dial12"; when: ((cluster.configurableBackground_index == 3)&&(cluster.skin_3_configurableDial_index==2))
                        PropertyChanges { target: skin_Blank_RPM_dail; source:"image/Skin_3_RPM_Dial2.png"}
                    }
                ]

                Image {
                    id: skin_Blank_RPM_pointer
                    //x: 650
                    y: 120
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.verticalCenter: parent.verticalCenter
                    z: 2
                    scale:0.9
                    opacity: switch(cluster.configurableBackground_index){case 3:1;break;case 12:1;break;case 13:1;break;default:0}
                    source: "image/Skin_Blank_Speedo_RPM_Pointer.png" //
                    states:[
                        State{
                            name: "skin_Blank_Speedo_pointer1"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==1))
                            PropertyChanges { target: skin_Blank_RPM_pointer; source:"image/Skin_Blank_Speedo_RPM_Pointer.png"}
                        },
                        State{
                            name: "skin_Blank_Speedo_pointer2"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==2))
                            PropertyChanges { target: skin_Blank_RPM_pointer; source:"image/Skin_Blank_Speedo_RPM_Pointer2.png"}
                        },
                        State{
                            name: "skin_Blank_Speedo_pointer3"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==3))
                            PropertyChanges { target: skin_Blank_RPM_pointer; source:"image/Skin_Blank_Speedo_RPM_Pointer3.png"}
                        }
                    ]
                    transform: Rotation  {
                        id: skin_Blank_RPM_pointer_Rotation
                        origin.x: 61
                        origin.y: 213
                        angle:switch(cluster.configurableBackground_index)
                              {
                              case 3:
                                  (Math.min(Math.max(-130, rpmMeter.value1*2.8 - 130), 200));
                                  break;
                              case 12:
                                  //                          (Math.min(Math.max(130, speedoMeter.value*2.6), 130));
                                  // Math.min(130,Math.max(0,(120-rpmMeter.value1*0.8)))
                                  Math.min(132,Math.max(0,(132-rpmMeter.value1*1.3)))

                              }
                        /**/
                        Behavior on angle  {
                            SpringAnimation  {
                                spring: 1.4
                                damping: .15
                            }
                        }
                    }
                }
            }

            Image {
                id: skin_Blank_Graphics
                x: switch(cluster.configurableBackground_index){case 3:300;break;case 12:300;break;case 13:300;break}
                y: switch(cluster.configurableBackground_index){case 3:82;break;case 12:5;break;case 13:5;break}
                z: switch(cluster.configurableBackground_index){case 3:0;break;case 12:2;break;case 13:2;break;}
                scale:0.53
                opacity: switch(cluster.configurableBackground_index){case 3:1;break;case 12:1;break;case 13:1;break;default:0}
                source: "image/Skin_Blank_Graphic.png"
                states:[
                    State{
                        name: "Skin_Blank_Graphic"; when: ((cluster.configurableBackground_index == 12)&&(cluster.skin_Blank_configurableDial_index == 1)||(cluster.configurableBackground_index == 13))
                        PropertyChanges { target: skin_Blank_Graphics; source:"image/Skin_Blank_Graphic.png"}
                    },
                    State{
                        name: "Skin_Blank_Graphic2"; when: ((cluster.configurableBackground_index == 12)&&(cluster.skin_Blank_configurableDial_index == 2))
                        PropertyChanges { target: skin_Blank_Graphics; source:"image/Skin_Blank_Graphic2.png"}
                    },
                    State{
                        name: "Skin_3_Graphic"; when: ((cluster.configurableBackground_index == 3)&&(cluster.skin_3_configurableDial_index == 1))
                        PropertyChanges { target: skin_Blank_Graphics; source:"image/Skin_3_Graphic.png"}
                    },
                    State{
                        name: "Skin_3_Graphic2"; when: ((cluster.configurableBackground_index == 3)&&(cluster.skin_3_configurableDial_index == 2))
                        PropertyChanges { target: skin_Blank_Graphics; source:"image/Skin_3_Graphic2.png"}
                    }
                ]


            }

            Image {
                id: skin_Blank_Speedo_dail
                x: 47
                y: -100
                //anchors.horizontalCenter: cluster.horizontalCenter-100
                //anchors.verticalCenter: cluster.verticalCenter
                z: 1
                scale:0.50
                opacity: switch(cluster.configurableBackground_index){case 3:1;break;case 12:1;break;case 13:1;break;default:0}
                source: "image/Skin_Blank_Speedo_Dial.png"
                states:[
                    State{
                        name: "Skin_Blank_Speedo_Dial1"; when: ((cluster.configurableBackground_index == 12)&&(cluster.skin_Blank_configurableDial_index == 1)||(cluster.configurableBackground_index == 13))
                        PropertyChanges { target: skin_Blank_Speedo_dail; source:"image/Skin_Blank_Speedo_Dial.png"}
                    },
                    State{
                        name: "Skin_Blank_Speedo_Dial12"; when: ((cluster.configurableBackground_index == 12)&&(cluster.skin_Blank_configurableDial_index == 2))
                        PropertyChanges { target: skin_Blank_Speedo_dail; source:"image/Skin_Blank_Speedo_Dial2.png"}
                    },
                    State{
                        name: "Skin_3_Speedo_Dial1"; when: ((cluster.configurableBackground_index == 3)&&(cluster.skin_3_configurableDial_index == 1))
                        PropertyChanges { target: skin_Blank_Speedo_dail; source:"image/Skin_3_Speedo_Dial.png"}
                    },
                    State{
                        name: "Skin_3_Speedo_Dial2"; when: ((cluster.configurableBackground_index == 3)&&(cluster.skin_3_configurableDial_index == 2))
                        PropertyChanges { target: skin_Blank_Speedo_dail; source:"image/Skin_3_Speedo_Dial2.png"}
                    }
                ]

                Image {
                    id: skin_Blank_Speedo_pointer
                    //x: 160
                    y: 120
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.verticalCenter: parent.verticalCenter
                    z: 2
                    scale:0.9
                    opacity: switch(cluster.configurableBackground_index){case 3:1;break;case 12:1;break;case 13:1;break;default:0}
                    source: "image/Skin_Blank_Speedo_RPM_Pointer.png"
                    states:[
                        State{
                            name: "skin_Blank_Speedo_pointer1"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==1))
                            PropertyChanges { target: skin_Blank_Speedo_pointer; source:"image/Skin_Blank_Speedo_RPM_Pointer.png"}
                        },
                        State{
                            name: "skin_Blank_Speedo_pointer2"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==2))
                            PropertyChanges { target: skin_Blank_Speedo_pointer; source:"image/Skin_Blank_Speedo_RPM_Pointer2.png"}
                        },
                        State{
                            name: "skin_Blank_Speedo_pointer3"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==3))
                            PropertyChanges { target: skin_Blank_Speedo_pointer; source:"image/Skin_Blank_Speedo_RPM_Pointer3.png"}
                        }
                    ]
                    transform: Rotation  {
                        id: skin_Blank_Speedo_pointer_Rotation
                        origin.x: 61
                        origin.y: 213
                        angle:switch(cluster.configurableBackground_index)
                              {
                              case 3:
                                  (Math.min(Math.max(-130, speedoMeter.value*2.2 - 130), 130));
                                  break;
                              case 12:
                                  (Math.min(Math.max(-130, speedoMeter.value*1.1 - 130), 0));
                                  break;
                              }
                        /**/
                        Behavior on angle  {
                            SpringAnimation  {
                                spring: 1.4
                                damping: .15
                            }
                        }
                    }
                }
            }
            Image {
                id: skin_Blank_FG_dail
                x: 260 //20
                y: 110 //250
                //anchors.horizontalCenter: parent.horizontalCenter
                //anchors.verticalCenter: parent.verticalCenter
                z: 0
                scale:0.5
                opacity: switch(cluster.configurableBackground_index){case 3:1;break;case 12:1;break;case 13:1;break;default:0}
                source: "image/Skin_Blank_FG_Dial.png"
                states:[
                    State{
                        name: "Skin_Blank_FG_Dial"; when: ((cluster.configurableBackground_index == 12)&&(cluster.skin_Blank_configurableDial_index == 1)||(cluster.configurableBackground_index == 13))
                        PropertyChanges { target: skin_Blank_FG_dail; source:"image/Skin_Blank_FG_Dial.png"}
                    },
                    State{
                        name: "Skin_Blank_FG_Dial2"; when: ((cluster.configurableBackground_index == 12)&&(cluster.skin_Blank_configurableDial_index == 2))
                        PropertyChanges { target: skin_Blank_FG_dail; source:"image/Skin_Blank_FG_Dial2.png"}
                    },
                    State{
                        name: "Skin_3_FG_Dial"; when: ((cluster.configurableBackground_index == 3)&&(cluster.skin_3_configurableDial_index == 1))
                        PropertyChanges { target: skin_Blank_FG_dail; source:"image/Skin_3_FG_Dial.png"}
                    },
                    State{
                        name: "Skin_3_FG_Dial2"; when: ((cluster.configurableBackground_index == 3)&&(cluster.skin_3_configurableDial_index == 2))
                        PropertyChanges { target: skin_Blank_FG_dail; source:"image/Skin_3_FG_Dial2.png"}
                    }
                ]

                Image {
                    id: skin_Blank_FG_pointer
                    //x: 60
                    y: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.verticalCenter: parent.verticalCenter
                    z: 2
                    scale:1
                    opacity: switch(cluster.configurableBackground_index){case 3:1;break;case 12:1;break;case 13:1;break;default:0}
                    source: "image/Skin_Blank_Gauge_Pointer.png"
                    states:[
                        State{
                            name: "skin_Blank_FG_pointer1"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==1))
                            PropertyChanges { target: skin_Blank_FG_pointer; source:"image/Skin_Blank_Gauge_Pointer.png"}
                        },
                        State{
                            name: "skin_Blank_FG_pointer2"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==2))
                            PropertyChanges { target: skin_Blank_FG_pointer; source:"image/Skin_Blank_Gauge_Pointer2.png"}
                        },
                        State{
                            name: "skin_Blank_FG_pointer3"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==3))
                            PropertyChanges { target: skin_Blank_FG_pointer; source:"image/Skin_Blank_Gauge_Pointer3.png"}
                        }
                    ]
                    transform: Rotation  {
                        id: skin_Blank_FG_pointer_Rotation
                        origin.x: 20
                        origin.y: 83
                        angle:{
                            (Math.min(Math.max(-130, speedoMeter.value*2.6 - 130), 130));
                        }
                        /**/
                        Behavior on angle  {
                            SpringAnimation  {
                                spring: 1.4
                                damping: .15
                            }
                        }
                    }
                }
            }
            Image {
                id: skin_Blank_TG_dail
                x: 795 //1025
                y: 110 //250
                z: 0
                scale:0.5
                opacity: switch(cluster.configurableBackground_index){case 3:1;break;case 12:1;break;case 13:1;break;default:0}
                source: "image/Skin_Blank_TG_Dial.png"
                states:[
                    State{
                        name: "Skin_Blank_TG_Dial"; when: ((cluster.configurableBackground_index == 12)&&(cluster.skin_Blank_configurableDial_index == 1)||(cluster.configurableBackground_index == 13))
                        PropertyChanges { target: skin_Blank_TG_dail; source:"image/Skin_Blank_TG_Dial.png"}
                    },
                    State{
                        name: "Skin_Blank_TG_Dial2"; when: ((cluster.configurableBackground_index == 12)&&(cluster.skin_Blank_configurableDial_index == 2))
                        PropertyChanges { target: skin_Blank_TG_dail; source:"image/Skin_Blank_TG_Dial2.png"}
                    },
                    State{
                        name: "Skin_3_TG_Dial"; when: ((cluster.configurableBackground_index == 3)&&(cluster.skin_3_configurableDial_index == 1))
                        PropertyChanges { target: skin_Blank_TG_dail; source:"image/Skin_3_TG_Dial.png"}
                    },
                    State{
                        name: "Skin_3_TG_Dial2"; when: ((cluster.configurableBackground_index == 3)&&(cluster.skin_3_configurableDial_index == 2))
                        PropertyChanges { target: skin_Blank_TG_dail; source:"image/Skin_3_TG_Dial2.png"}
                    }
                ]

                Image {
                    id: skin_Blank_TG_pointer
                    //x: 850
                    y: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.verticalCenter: parent.verticalCenter
                    z: 2
                    scale:1
                    opacity:switch(cluster.configurableBackground_index){case 3:1;break;case 12:1;break;case 13:1;break;default:0}
                    source: "image/Skin_Blank_Gauge_Pointer.png"
                    states:[
                        State{
                            name: "skin_Blank_TG_pointer1"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==1))
                            PropertyChanges { target: skin_Blank_TG_pointer; source:"image/Skin_Blank_Gauge_Pointer.png"}
                        },
                        State{
                            name: "skin_Blank_TG_pointer2"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==2))
                            PropertyChanges { target: skin_Blank_TG_pointer; source:"image/Skin_Blank_Gauge_Pointer2.png"}
                        },
                        State{
                            name: "skin_Blank_TG_pointer3"; when: (((cluster.configurableBackground_index == 12)||(cluster.configurableBackground_index == 3))&&(cluster.skin_12_configurablePointer_index==3))
                            PropertyChanges { target: skin_Blank_TG_pointer; source:"image/Skin_Blank_Gauge_Pointer3.png"}
                        }
                    ]
                    transform: Rotation  {
                        id: skin_Blank_TG_pointer_Rotation
                        origin.x: 20
                        origin.y: 83
                        angle:{
                            (Math.min(Math.max(-130, speedoMeter.value*2.6 - 130), 130));
                        }
                        /**/
                        Behavior on angle  {
                            SpringAnimation  {
                                spring: 1.4
                                damping: .15
                            }
                        }
                    }
                }
            }
        }


        Item  {
            id: speedoMeter
            property real value : 0
            width: 300; height: 300
            x: 477
            y: 106
            z: 0
            opacity: 1
            anchors.verticalCenterOffset: -4
            anchors.horizontalCenterOffset: 227
            anchors.centerIn: parent

            Image  {
                id: speed_inactive;
                x: -9;
                y: 28;
                opacity: switch(cluster.configurableBackground_index){case 2:0;break;case 3:0;break;case 4:0;break;case 5:0;break;case 8:0;break;case 9:0;break;case 12:0;break;case 13:0;break;default:1}
                z: 3;

                states:[
                    State {
                        name: "change_speed_dial1"; when: cluster.configurableDial_index == 1
                        PropertyChanges { target: speed_inactive; source:"image/RPM_01.png"} //scale:1.2
                    },
                    State {
                        name: "change_speed_dial2"; when: cluster.configurableDial_index == 2
                        PropertyChanges { target: speed_inactive; source:"image/speed_inactive.png"} //scale:0.7
                    },
                    State {
                        name: "change_speed_dial3"; when: cluster.configurableDial_index == 3

                        PropertyChanges { target: speed_inactive;source:"image/original Speedo.png"}

                    }
                ]

            }

            CircleGraph{
                id: speed_pie
                anchors.fill:speed_inactive
                z:0
                scale:0.8
                opacity:((cluster.configurableBackground_index==6 ||cluster.configurableBackground_index==1 ||cluster.configurableBackground_index==7) &&(cluster.configurableDial_index == 3))? 1:0
                startAngle:2100
                endValue: cluster.fuelDummy
                color: "yellow"
                multicolor: true
                property int clickedEndValue


            }


            Image {
                id: speedOverlay
                x: switch(cluster.configurableDial_index){case 1:135;break;case 2:124;break;case 3:124;break;}
                y: switch(cluster.configurableDial_index){case 1:140;break;case 2:160;break;case 3:160;break;}
                z: 3
                opacity: 0
                source: "image/overlay_active.png"
            }

            Image  {
                id: needle1
                x: switch(cluster.configurableBackground_index){case 2:188;break;case 3:188;break;case 4:188;break;default:switch(cluster.configurableDial_index){case 1:127;break;case 2:124;break;case 3:112;break;}}//73
                y: switch(cluster.configurableBackground_index){case 2:111;break;case 3:111;break;case 4:111;break;default:switch(cluster.configurableDial_index){case 1:72;break;case 2:91;break;case 3:90;break;}}//-14
                clip: true
                opacity: switch(cluster.configurableBackground_index){case 3:0;break;case 4:0;break;case 5:0;break;case 8:0;break;case 9:0;break;case 12:0;break;case 13:0;break;default:1}
                z: 4
                smooth: true
                scale:1
                source:cluster.configurablePointer
                transform: Rotation  {
                    id: needle1Rotation
                    origin.x: 19 //5
                    origin.y: 80 //65
                    angle: switch(cluster.configurableDial_index)
                           {
                           case 1:(Math.min(Math.max(-115, speedoMeter.value*2.6 - 115), 185));
                               break;
                           case 2:(Math.min(Math.max(-130, speedoMeter.value*2.2 - 130), 133));
                               break;
                           case 3:(Math.min(Math.max(-123, speedoMeter.value*2.2 - 123), 90));
                               break;
                           }
                    /**/
                    Behavior on angle  {
                        SpringAnimation  {
                            spring: 1.4
                            damping: .15
                        }
                    }
                }

            }
        }

        Item  {
            id: rpmMeter
            property real value1 : 0
            width: 300; height: 300

            x: 300
            y: 118
            visible: true
            z: 0
            // scale:0.5
            opacity: 1
            anchors.verticalCenterOffset: 8
            anchors.horizontalCenterOffset: -207
            anchors.centerIn: parent

            Image  {
                id: rpm_inactive;
                x: -30;
                y: 20;
                opacity: switch(cluster.configurableBackground_index){case 2:0;break;case 3:0;break;case 4:0;break;case 5:0;break;case 8:0;break;case 9:0;break;case 12:0;break;case 13:0;break;default:1}

                z: 3;
                //scale:0.7
                states:[
                    State {
                        name: "change_rpm_dial1"; when: cluster.configurableDial_index == 1;
                        PropertyChanges { target: rpm_inactive; source:"image/Speedo_01.png"}//scale:1.2
                    },
                    State {
                        name: "change_rpm_dial2"; when: cluster.configurableDial_index == 2
                        PropertyChanges { target: rpm_inactive; source:"image/rpm_inactive.png";} //scale:0.7
                    },
                    State {
                        name: "change_rpm_dial3"; when: cluster.configurableDial_index == 3
                        PropertyChanges { target: rpm_inactive; source:"image/Original RPM.png";} //scale:0.7
                    }
                ]

                smooth: true
            }

            CircleGraph{
                id: pie_rpm
                anchors.fill:rpm_inactive
                z:0
                scale:0.8
                opacity:((cluster.configurableBackground_index==6 ||cluster.configurableBackground_index==1 ||cluster.configurableBackground_index==7) && (cluster.configurableDial_index == 3))? 1:0
                startAngle:900
                spanAngle:-1728
                endValue: -(30-cluster.fuelDummy)
                color: "green"
                multicolor: true
                property int clickedEndValue


            }

            Image {
                id: rpmOverlay
                x: switch(cluster.configurableDial_index){case 1:78;break;case 2:98;break;case 3:98;break;}
                y: switch(cluster.configurableDial_index){case 1:127;break;case 2:157;break;case 3:157;break;}
                z: 3
                opacity: 0
                source: "image/overlay_active.png"
                scale:rpmMeter.scale
            }

            Image  {
                id: needle
                x: switch(cluster.configurableBackground_index){case 2:55;break;case 3:55;break;case 4:55;break;default:switch(cluster.configurableDial_index){case 1:74;break;case 2:102;break;case 3:91;break;}}//51
                y: switch(cluster.configurableBackground_index){case 2:99;break;case 3:99;break;case 4:99;break;default:switch(cluster.configurableDial_index){case 1:64;break;case 2:84;break;case 3:82;break;}}//-22
                z:4
                clip: true
                scale: 1
                opacity: switch(cluster.configurableBackground_index){case 3:0;break;case 4:0;break;case 5:0;break;case 8:0;break;case 9:0;break;case 12:0;break;case 13:0;break;default:1}
                smooth: true
                source: cluster.configurablePointer
                transform: Rotation  {
                    id: needleRotation
                    origin.x: 19 //5
                    origin.y: 80 //65
                    angle:switch(cluster.configurableDial_index)
                          {
                          case 1:(Math.min(Math.max(-180, rpmMeter.value1*2.6 - 180),150));
                              break;
                          case 2:(Math.min(Math.max(-130, rpmMeter.value1*2.6 - 130),133));
                              break;
                          case 3:(Math.min(Math.max(-93, rpmMeter.value1*2.6 - 130),133));
                              break;
                          }
                    /**/
                    Behavior on angle{
                        SpringAnimation{
                            spring: 1.4
                            damping: .15
                        }
                    }
                }
            }

        }



        states: [


            State {
                name: "parseMenuOption"
                when: listmenu.activeFocus
                PropertyChanges { target: listmenu; x:555;opacity:1}
            },

            State{
                name: "parsePointers"
                when:viewPointeroption.activeFocus
                PropertyChanges {target:viewPointeroption; x:460}

            },

            State{
                name: "parseBackground"
                when:viewBackgroundoption.activeFocus
                PropertyChanges {target:viewBackgroundoption; x:425}

            },

            State{
                name: "parseDial"
                when:viewDialoption.activeFocus
                PropertyChanges {target:viewDialoption; x:465}

            },

            State{
                name: "parseCalender"
                when:viewCalendaroption.activeFocus
                PropertyChanges {target:viewCalendaroption; x:500; y:100} //x:425
            },

            State {
                name: "dateTimeAppear"
                when: viewDateTimeoption.activeFocus
                PropertyChanges { target:viewDateTimeoption; x:565;y:200;opacity:1}
            }

        ]


        transitions: Transition {
            NumberAnimation { properties: "x"; duration: 600; easing.type: Easing.OutQuint }
        }


        Keys.onEscapePressed:
        {

            if(viewDateTimeoption.activeFocus==false)
            {
                cluster.navigation_step -= 1;

                switch(cluster.navigation_step)
                {
                case 0:

                    listmenu.focus=false
                    cluster.menu = 0
                    cluster.startStop = 0
                    break
                case 1:

                    if(cluster.startStopEnable == true)
                    {
                        cluster.startStop = 0
                    }
                    else{
                        listmenu.focus=false
                        cluster.menu = 1
                    }
                    break
                case 2:
                    listmenu.focus=true
                    cluster.menu = 0
                    break
                default:

                    cluster.navigation_step=0
                    if((cluster.menuFlag == true))
                    {
                        cluster.startStop = 1
                        cluster.menu = 0
                        cluster.menuFlag = false
                    }
                    else if((cluster.startStopEnable == true))//||(cluster.startStop == 1)
                    {
                        cluster.menu = 1
                        cluster.startStop = 0
                        cluster.startStopEnable = false
                    }
                    else if((cluster.startStop == 1)||(cluster.menu == 1))
                    {
                        if(cluster.startStop == 1){cluster.startStopEnable = true;cluster.menuFlag = false;}
                        else if (cluster.menu == 1){cluster.menuFlag = true;cluster.startStopEnable = false;}

                        cluster.menu = 0
                        cluster.startStop = 0

                    }

                }
            }
        }
        Keys.onReturnPressed:
        {
            cluster.navigation_step += 1;
            switch(cluster.navigation_step)
            {
            case 0:
                listmenu.focus=false
                cluster.menu = 0
                cluster.startStop = 0
                break
            case 1:
                if((cluster.menuFlag == true)||(cluster.menu == 1))
                {
                    cluster.menuFlag = true
                    cluster.menu = 1
                    listmenu.focus=false
                }
                else if(cluster.startStop == 1)
                {
                    cluster.startStopEnable = true
                    startstop()
                }

                break
            case 2:
                if(cluster.startStop == 1 )//cluster.startStopEnable == true
                {startstop()}
                else
                {
                    listmenu.focus=true
                    cluster.menu = 0
                }
                break
            case 3:
                if(cluster.startStop == 1 )//cluster.startStopEnable == true
                {
                    cluster.navigation_step = 1
                    startstop()
                }
                else
                {listmenu.focus=false;}
                break
            default :

                break

            }
        }
        FocusScope {
            id: configurableFocus
            z:5;width: parent.width; height: parent.height
            focus:true


            Rectangle {
                id: menuOption
                width: 120; height: 30;
                x:600;y:120;
                color: "grey"
                anchors.topMargin: 3
                antialiasing: true
                radius: 10
                opacity:0
                focus:true

                Text{
                    id:menu
                    anchors.centerIn: menuOption
                    text:"Menu"
                    font.pointSize: 12

                }

                states: State {
                    name: "focusMenu"; when: (cluster.menu == 1) //&&(cluster.startStopEnable == false)) //(cluster.menuFlag == true)
                    PropertyChanges { target: menuOption; color: "#FCFFF5"; scale: 1.1; opacity:1}
                    PropertyChanges { target: menu; font.pixelSize: 16 }
                }

                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 100 }
                }


            }

            Listmenu {
                id: listmenu
                y:140; width: parent.width; height: parent.height ;anchors.margins:3
                opacity:0

            }

            PointerView{
                id:viewPointeroption ;width: 350; height:350;x:-1300;y:100;z:3

            }

            BackgroundView{
                //id:viewBackgroundoption;width:350;height:350;x:1300;y:100;z:3
                id:viewBackgroundoption;width:370;height:370;x:1300;y:100;z:3

            }

            DialView{
                id:viewDialoption;width:350;height:350;x:1300;y:100;z:3

            }


            CalendarView {
                id:viewCalendaroption;x:1800
            }
            SetDateTimeView {
                id:viewDateTimeoption;x:1500;y:100;z:3   //anchors.centerIn: parent
            }


            StartstopButton{

                id:startStopbutton
                width:parent.width;height:320;y:30
                opacity:0

                states: State
                {
                name: "focusStartStopButton"; when: (cluster.startStop == 1)
                PropertyChanges { target: startStopbutton; scale: 0.9;opacity:1 }
            }

            transitions: Transition
            {
            NumberAnimation { properties: "scale"; duration: 100 }
            }

    }
}
function startstop()
{
    flipped = !flipped
    cluster.startFlag = !cluster.startFlag
    if(cluster.startFlag == true)
    {

        dialEffectStop.stop()                      // stop dial animation
        dialEffectStart.start()                    // start dial effect animation
        indicatorAnimateFocus.stop()               // stop indicator animation
        indicatorAnimatedDim.start()               // startindictor effect animation
        rpmAndspeedUpdate.running = true           // start rpmAndspeedUpdate timer
        dummyAnimation.running=true
        fuelAnnimation.start()



    }
    else {

        dialEffectStart.stop()                     // stop dial effect animation
        dialEffectStop.start()                     // start dial effect stop animation
        indicatorAnimateFocus.start()              // start indicator focus annimation
        indicatorAnimatedDim.stop()                // stop indicator animation
        dummyAnimation.running=false
        fuelAnnimation.stop()

    }

}

SequentialAnimation on fuelDummy {
    id:fuelAnnimation
    loops: Animation.Infinite
    running: false
    NumberAnimation {
        from: 0
        to: 30
        duration: 3000
    }
    NumberAnimation {
        from:30
        to: 0
        duration: 3000
    }
}






// start dial glowing effect
ParallelAnimation{
    id: dialEffectStart
    running: false

    NumberAnimation { target:skin_9;  property:"x";to:-130; duration: 1500}
    NumberAnimation { target:skin_9;  property:"y";to:-50; duration: 1500}
    NumberAnimation { target:skin_9;  property:"scale";to:1.2; duration: 1500}
    NumberAnimation { target:skin_9_RPM_dail;  property:"x";to:skin_9_RPM_dail.x+100; duration: 1500}
    NumberAnimation { target:skin_9_FG_TG_dail;  property:"x";to:skin_9_FG_TG_dail.x-100; duration: 1500}

    NumberAnimation { target:skin_Blank;  property:"x";to:switch(cluster.configurableBackground_index){case 13:60;break;default:0} duration: 1500}
    NumberAnimation { target:skin_Blank;  property:"y";to:0; duration: 1500}
    NumberAnimation { target:skin_Blank;  property:"scale";to:switch(cluster.configurableBackground_index){case 13:0.90;break;default:1} duration: 1500}
    NumberAnimation { target:skin_Blank_FG_dail;  property:"x";to:20; duration: 1500}
    NumberAnimation { target:skin_Blank_FG_dail;  property:"y";to:250; duration: 1500}
    NumberAnimation { target:skin_Blank_TG_dail;  property:"x";to:1025; duration: 1500}
    NumberAnimation { target:skin_Blank_TG_dail;  property:"y";to:250; duration: 1500}

    NumberAnimation { target:digitalSpeed;  property:"x";to:switch(cluster.configurableBackground_index){case 9:632;break;default:digitalSpeed.x+180}     duration: 500 }
    NumberAnimation { target:digitalSpeed;  property:"y";to:switch(cluster.configurableBackground_index){case 9:180;break;default:digitalSpeed.y-20}      duration: 500 }
    NumberAnimation { target:digitalSpeed;  property:"visible";to:1;duration: 100}
    NumberAnimation { target:digitalSpeed;  property: "scale";to:1; duration: 1500}
    NumberAnimation { target:digitalSpeed;  property:"opacity";to:switch(cluster.configurableBackground_index){case 9:1;break;default:0}      duration: 500 }

    NumberAnimation { target:display_gear;  property:"opacity";to:1; duration: 1500}
    NumberAnimation { target:gear_image;    property:"opacity";to:1; duration: 1500}

    NumberAnimation { target:rpm_active;    property:"opacity";to:switch(cluster.configurableBackground_index){case 2:0;break;case 3:0;break;case 9:0;break;case 12:0;break;default:switch(cluster.configurableDial_index){case 2:1;break;default:0;break;}}duration: 1000}
    NumberAnimation { target:rpm_active;    property:"x";to:rpm_active.x-179;  duration: 500 }
    NumberAnimation { target:rpm_active;    property:"y";to:rpm_active.y-30;   duration: 500 }
    NumberAnimation { target:rpm_active;    property:"scale";to:1.2;           duration: 500 }
    NumberAnimation { target:rpm_inactive;  property:"scale";to:switch(cluster.configurableBackground_index){default:switch(cluster.configurableDial_index){case 1:1.40;break;default:1.2;break;}}duration: 500}
    NumberAnimation { target:rpm_inactive;  property:"x";to:switch(cluster.configurableBackground_index){default:switch(cluster.configurableDial_index){case 1:rpm_inactive.x-145;break;default:rpm_inactive.x-175;break;}}duration: 500 }
    NumberAnimation { target:rpm_inactive;  property:"y";to:switch(cluster.configurableBackground_index){default:switch(cluster.configurableDial_index){case 1:rpm_inactive.y-2;break;default:rpm_inactive.y-30;break;}}duration: 500 }
    NumberAnimation { target:needle;        property:"x"; to:switch(cluster.configurableBackground_index){case 2:55;break;default:switch(cluster.configurableDial_index){case 1:needle.x-152;break;case 2:needle.x-179;break;case 3:needle.x-177;break;}}duration: 500}//-178
    NumberAnimation { target:needle;        property:"y"; to:switch(cluster.configurableBackground_index){case 2:99;break;default:switch(cluster.configurableDial_index){case 1:needle.y-20;break;case 2:needle.y-30;break;case 3:needle.y-32;break;}}duration: 500}//-32
    NumberAnimation { target:needle;        property:"scale"; to:switch(cluster.configurableBackground_index){case 2:1;break;default:switch(cluster.configurableDial_index){case 1:1.2;break;case 2:1.2;break;case 3:1.2;break;}}duration: 500}

    //NumberAnimation { target:rpmOverlay; property: "x"; to:switch(cluster.configurableDial_index){case 1:rpmOverlay.x-155;break;case 2:rpmOverlay.x-179;break;}duration: 500}
    //NumberAnimation { target:rpmOverlay; property: "y"; to:switch(cluster.configurableDial_index){case 1:rpmOverlay.y-20;break;case 2:rpmOverlay.y-30;break;}duration: 500}
    //NumberAnimation { target:rpmOverlay; property: "scale"; to:switch(cluster.configurableDial_index){case 1:1.5;break;case 2:1.2;break;}duration: 500}

    NumberAnimation { target:speed_active;      property:"opacity";to:switch(cluster.configurableBackground_index){case 2:0;break;case 3:0;break;case 9:0;break;case 12:0;break;default:switch(cluster.configurableDial_index){case 2:1;break;default:0;break;}}duration: 1000}
    NumberAnimation { target:speed_active;      property:"x";to:speed_active.x+195; duration: 500 }
    NumberAnimation { target:speed_active;      property:"y";to:speed_active.y-30; duration: 500 }
    NumberAnimation { target:speed_active;      property:"scale";to:1.2; duration: 500 }
    NumberAnimation { target:speed_inactive;    property:"scale";to:switch(cluster.configurableBackground_index){default:switch(cluster.configurableDial_index){case 1:1.40;break;default:1.2;break;}}duration: 500 }
    NumberAnimation { target:speed_inactive;    property:"x";to:switch(cluster.configurableBackground_index){default:switch(cluster.configurableDial_index){case 1:speed_inactive.x+175;break;default:speed_inactive.x+195;break;}}duration: 500 }
    NumberAnimation { target:speed_inactive;    property:"y";to:switch(cluster.configurableBackground_index){default:switch(cluster.configurableDial_index){case 1:speed_inactive.y-2;break;default:speed_inactive.y-30;break;}}duration: 500 }
    NumberAnimation { target:needle1;           property:"x";to:switch(cluster.configurableBackground_index){case 2:188;break;default:switch(cluster.configurableDial_index){case 1:needle1.x+182;break;case 2:needle1.x+195;break;case 3:needle1.x+195;break;}}duration: 500} //+193
    NumberAnimation { target:needle1;           property:"y";to:switch(cluster.configurableBackground_index){case 2:111;break;default:switch(cluster.configurableDial_index){case 1:needle1.y-20;break;case 2:needle1.y-30;break;case 3:needle1.y-30;break;}}duration: 500} //-38
    NumberAnimation { target:needle1;           property:"scale";to:switch(cluster.configurableBackground_index){case 2:1;break;default:switch(cluster.configurableDial_index){case 1:1.2;break;case 2:1.2;break;case 3:1.2;break;}}duration: 500}
    //NumberAnimation { target:speedOverlay; property: "x"; to:switch(cluster.configurableDial_index){case 1:needle1.x+173;break;case 2:speedOverlay.x+195;break;}duration: 500}
    //NumberAnimation { target:speedOverlay; property: "y"; to:switch(cluster.configurableDial_index){case 1:needle1.y+32;break;case 2:speedOverlay.y-30;break;}duration: 500}
    //NumberAnimation { target:speedOverlay; property: "scale"; to:switch(cluster.configurableDial_index){case 1:1.5;break;case 2:1.2;break;}duration: 500}

    NumberAnimation { target: turn_left; property: "opacity"; to: 0.2; duration: 100}
    NumberAnimation { target: turn_right; property: "opacity"; to: 0.2; duration: 500}
    NumberAnimation { target: turn_left; property: "x"; to: turn_left.x-70; duration: 500}
    NumberAnimation { target: turn_right; property: "x"; to: turn_right.x+70; duration: 500}

    NumberAnimation{ target: totalDistance; property: "opacity"; to: 1.0; duration: 1000}
    NumberAnimation{target: totalDistance; property: "x"; to: 130; duration: 800}
    NumberAnimation{target: totalDistance; property: "y"; to: 450; duration: 800}
    NumberAnimation{target: destination; property: "opacity"; to: 1.0; duration: 1000}
    NumberAnimation{target: destination; property: "x"; to: 350; duration: 800}
    NumberAnimation{target: destination; property: "y"; to: 450; duration: 800}
    NumberAnimation{target: time; property: "opacity"; to: 1.0; duration: 1000}
    NumberAnimation{target: time; property: "x"; to: 750; duration: 800}
    NumberAnimation{target: time; property: "y"; to: 450; duration: 800}
    NumberAnimation{target: date; property: "opacity"; to: 1.0; duration: 1000}
    NumberAnimation{target: date; property: "x"; to: 1000; duration: 800}
    NumberAnimation{target: date; property: "y"; to: 450; duration: 800}


    NumberAnimation { target:speed_pie;  property:"scale";to:1; duration: 1500}
    NumberAnimation { target:pie_rpm;  property:"scale";to:1; duration: 1500}



}

// decrease active effect of dial
ParallelAnimation{
    id: dialEffectStop
    running: false

    NumberAnimation { target:skin_9;  property:"x";to:130; duration: 1500}
    NumberAnimation { target:skin_9;  property:"y";to:60; duration: 1500}
    NumberAnimation { target:skin_9;  property:"scale";to:0.8; duration: 1500}

    NumberAnimation { target:skin_9_RPM_dail;  property:"x";to:190; duration: 1500} //290
    NumberAnimation { target:skin_9_FG_TG_dail;  property:"x";to:850; duration: 1500} //750

    NumberAnimation { target:skin_Blank;  property:"x";to:140; duration: 1500}
    NumberAnimation { target:skin_Blank;  property:"y";to:60; duration: 1500}
    NumberAnimation { target:skin_Blank;  property:"scale";to:0.8; duration: 1500}
    NumberAnimation { target:skin_Blank_FG_dail;  property:"x";to:260; duration: 1500}
    NumberAnimation { target:skin_Blank_FG_dail;  property:"y";to:110; duration: 1500}
    NumberAnimation { target:skin_Blank_TG_dail;  property:"x";to:795; duration: 1500}
    NumberAnimation { target:skin_Blank_TG_dail;  property:"y";to:110; duration: 1500}

    NumberAnimation { target:rpm_active;    property:"opacity";to: 0;   duration: 1500}
    NumberAnimation { target:rpm_active;    property:"x";to:241 ;       duration: 500 } //241
    NumberAnimation { target:rpm_active;    property:"y";to:99;         duration: 500 }
    NumberAnimation { target:rpm_active;    property:"scale";to:1;      duration: 500 }
    NumberAnimation { target:rpm_inactive;  property:"y";to:20;         duration: 500 }
    NumberAnimation { target:rpm_inactive;  property:"x";to: -30;       duration: 500 }
    NumberAnimation { target:rpm_inactive;  property:"scale";to:1;      duration: 500 }
    NumberAnimation { target:needle;        property:"x";to:switch(cluster.configurableBackground_index){case 2:55;break;default:switch(cluster.configurableDial_index){case 1:74;break;case 2:102;break;case 3:91;break;}}duration: 500}//51
    NumberAnimation { target:needle;        property:"y";to:switch(cluster.configurableBackground_index){case 2:99;break;default:switch(cluster.configurableDial_index){case 1:64;break;case 2:84; break;case 3:82;break;}}duration: 500}//-22
    NumberAnimation { target:needle;        property:"scale"; to:1;     duration: 500}

    NumberAnimation { target:speed_active;      property:"x";to: 695;       duration: 500 }
    NumberAnimation { target:speed_active;      property:"opacity"; to: 0;  duration: 1500}
    NumberAnimation { target:speed_active;      property:"y";to: 95;        duration: 500 }
    NumberAnimation { target:speed_active;      property:"scale";to: 1;     duration: 500 }
    NumberAnimation { target:speed_inactive;    property:"x";to: -9;        duration: 500 }
    NumberAnimation { target:speed_inactive;    property:"y";to: 28;        duration: 500 }
    NumberAnimation { target:speed_inactive;    property:"scale";to:1;      duration: 500 }
    NumberAnimation { target:needle1;           property:"x";to:switch(cluster.configurableBackground_index){case 2:188;break;default:switch(cluster.configurableDial_index){case 1:127;break;case 2:124;break;case 3:112;break;}}duration: 500}//73
    NumberAnimation { target:needle1;           property:"y";to:switch(cluster.configurableBackground_index){case 2:111;break;default:switch(cluster.configurableDial_index){case 1:72; break;case 2:91; break;case 3:90; break;}}duration: 500}//-14
    NumberAnimation { target:needle1;           property:"scale"; to:1;     duration: 500 }


    ///NumberAnimation { target: digitalSpeed; property: "x"; to: 840; duration: 500}
    ///NumberAnimation { target: digitalSpeed; property: "y"; to: 280; duration: 500}
    NumberAnimation { target: digitalSpeed; property: "scale";to:0.5; duration: 1500}
    NumberAnimation { target: digitalSpeed; property: "visible";to:0; duration: 2000}
    //NumberAnimation { target:rpmOverlay; property: "x"; to:switch(cluster.configurableDial_index){case 1:78;break;case 2:98;break;}duration: 500}
    ///NumberAnimation { target:speed_up; property:"x";to:840; duration: 500 }
    ///NumberAnimation { target:speed_up; property:"y";to:210; duration: 500 }
    ///NumberAnimation { target:speed_up; property:"visible";to:0; duration: 100}
    ///NumberAnimation { target:speed_down; property:"x";to:840; duration: 500 }
    ///NumberAnimation { target:speed_down; property:"y";to:250; duration: 500 }
    ///NumberAnimation { target:speed_down; property:"visible";to:0; duration: 100}
    NumberAnimation { target:display_gear; property:  "opacity"; to: 0; duration: 100}
    NumberAnimation { target:gear_image; property:  "opacity"; to: 0; duration: 100}
    NumberAnimation{target: skin_9_car; property: "scale"; to: 0.05; duration: 100}
    NumberAnimation{target: skin_9_car; property: "opacity"; to: 0; duration: 100}


    //NumberAnimation { target:rpmOverlay; property: "y"; to:switch(cluster.configurableDial_index){case 1:127;break;case 2:157;break;}duration: 500}



    //NumberAnimation { target:rpmOverlay; property: "scale"; to:1; duration: 500}


    NumberAnimation { target: turn_left; property: "x"; to: 560; duration: 500}
    NumberAnimation { target: turn_right; property: "x"; to: 660; duration: 500}
    NumberAnimation { target: turn_left; property: "opacity"; to: 1; duration: 500}
    NumberAnimation { target: turn_right; property: "opacity"; to: 1; duration: 500}
    NumberAnimation { target: turn_left; property: "opacity"; to: 0; duration: 10}
    NumberAnimation { target: turn_right; property: "opacity"; to: 0; duration: 10}

    //Throwing the Speedo meter sideways
    //NumberAnimation { target:speedOverlay; property: "x"; to:switch(cluster.configurableDial_index){case 1:135;break;case 2:124;break;}duration: 500}
    //NumberAnimation { target:speedOverlay; property: "y"; to:switch(cluster.configurableDial_index){case 1:140;break;case 2:160;break;}duration: 500}

    //NumberAnimation { target:speedOverlay; property: "scale"; to:1; duration: 500}

    //NumberAnimation { target:petrol_indicator; property: "x"; to: 980; duration: 500 }
    //NumberAnimation { target:petrol_indicator; property: "y"; to: 59; duration: 500 }



    NumberAnimation{target: totalDistance; property: "opacity"; to: 0; duration: 100}
    NumberAnimation{target: totalDistance; property: "x"; to: 363; duration: 200}
    NumberAnimation{target: totalDistance; property: "y"; to: 131; duration: 200}
    NumberAnimation{target: destination; property: "opacity"; to: 0; duration: 100}
    NumberAnimation{target: destination; property: "x"; to: 363; duration: 200}
    NumberAnimation{target: destination; property: "y"; to: 131; duration: 200}
    NumberAnimation{target: time; property: "opacity"; to: 0; duration: 100}
    NumberAnimation{target: time; property: "x"; to: 363; duration: 200}
    NumberAnimation{target: time; property: "y"; to: 131; duration: 200}
    NumberAnimation{target: date; property: "opacity"; to: 0; duration: 100}
    NumberAnimation{target: date; property: "x"; to: 363; duration: 200}
    NumberAnimation{target: date; property: "y"; to: 131; duration: 200}


    NumberAnimation {target: oil; property: "visible";to:0; duration: 100}
    NumberAnimation {target: brake; property: "visible";to:0; duration: 100}
    NumberAnimation {target: fuelLeak; property: "visible";to:0; duration: 100}
    NumberAnimation {target: battery; property: "visible";to:0; duration: 100}
    NumberAnimation {target: parkinglight; property: "visible";to:0; duration: 100}
    NumberAnimation {target: highBeam; property: "visible";to:0; duration: 100}
    NumberAnimation {target: turnleft; property: "visible";to:0; duration: 100}
    NumberAnimation {target: turnright; property: "visible";to:0; duration: 100}
    NumberAnimation{ target:low_oil; property: "scale"; to: 0.45; duration: 50}

    /////// Back to pavellian from dummyAutomation ////
    NumberAnimation{target: highbeam; property:  "x"; to: 230; duration: 10}
    NumberAnimation{target: highbeam; property:  "y"; to: 65; duration: 10}
    NumberAnimation{target: highbeam; property:  "scale"; to: 0.4; duration: 10}
    NumberAnimation{target: highBeam; property: "visible"; to: 0; duration: 100}

    NumberAnimation{ target:low_oil; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:low_oil; property: "x"; to: 540; duration: 10}
    NumberAnimation{ target:low_oil; property: "y"; to: 92; duration: 10}
    NumberAnimation{target: low_oil; property:  "scale"; to:0.45; duration: 10}
    NumberAnimation{ target:oil; property: "visible"; to: 0; duration: 100}

    NumberAnimation{ target:battery_low; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:battery_low; property: "x"; to: 820; duration: 10}
    NumberAnimation{ target:battery_low; property: "y"; to: 60; duration: 10}
    NumberAnimation{target: battery_low; property:  "scale"; to: 0.4; duration: 10}
    NumberAnimation{ target:battery; property: "visible"; to: 0; duration: 100}

    NumberAnimation{ target:petrol_indicator; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:petrol_indicator; property: "x"; to: 740; duration: 10}
    NumberAnimation{ target:petrol_indicator; property: "y"; to: 38; duration: 10}
    NumberAnimation{target: petrol_indicator; property:  "scale"; to: 0.3; duration: 10}
    NumberAnimation{ target:fuelLeak; property: "visible"; to: 0; duration: 100}

    NumberAnimation{ target:parking_light; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:parking_light; property: "x"; to: 540; duration: 10}
    NumberAnimation{ target:parking_light; property: "y"; to: 92; duration: 10}
    NumberAnimation{ target:parking_light; property:  "scale"; to:0.45; duration: 10}
    NumberAnimation{ target:parkinglight; property: "visible"; to: 0; duration: 100}

    NumberAnimation{ target:brakefailure; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:brakefailure; property: "x"; to: 540; duration: 10}
    NumberAnimation{ target:brakefailure; property: "y"; to: 92; duration: 10}
    NumberAnimation{ target:brakefailure; property:  "scale"; to:0.45; duration: 10}
    NumberAnimation{ target:brake; property: "visible"; to: 0; duration: 100}

    NumberAnimation { target:speed_pie;  property:"scale";to:0.8; duration: 1500}
    NumberAnimation { target:pie_rpm;  property:"scale";to:0.8; duration: 1500}

}



//increase all indicator opacity
SequentialAnimation{
    id: indicatorAnimateFocus
    running: false


    ///NumberAnimation{target: fuel_gauge; property:  "opacity"; to: 0.1; duration: 100}
    NumberAnimation{target: neutral; property:  "opacity"; to: 1.0; duration: 1500}
    NumberAnimation{target: stop_engine; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: water_in_fuel; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: low_aux_air; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: batt_col; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: highbeam; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: setbelt_col; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: trans_1; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: dc_dc_fail; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: rear_fog; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: low_oil; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: filter; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: glow_plug; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: petrol_indicator; property: "opacity"; to: 1; duration: 100 }
    NumberAnimation{target: cabin_lock; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: exhaust; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: battery_low; property: "opacity"; to: 1; duration: 100}
    NumberAnimation{target: temp; property: "opacity"; to: 1; duration: 100}
    NumberAnimation{target: oilIndication; property: "opacity"; to: 1; duration: 100}
    NumberAnimation{target: engine_check; property: "opacity"; to: 1; duration: 100}
    NumberAnimation{target: immobilizer; property: "opacity"; to: 1; duration: 100}

}

// decrease all indicators opacity
SequentialAnimation{
    id: indicatorAnimatedDim
    running: false
    ///NumberAnimation{target: fuel_gauge; property:  "opacity"; to: 1.0; duration: 100}
    NumberAnimation{target: neutral; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: stop_engine; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: water_in_fuel; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: low_aux_air; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: batt_col; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: highbeam; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: setbelt_col; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: trans_1; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: dc_dc_fail; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: rear_fog; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: low_oil; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: filter; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: glow_plug; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: petrol_indicator; property: "opacity"; to: 0.04; duration: 100 }
    NumberAnimation{target: cabin_lock; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: exhaust; property:  "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: battery_low; property: "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: temp; property: "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: oilIndication; property: "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: engine_check; property: "opacity"; to: 0.04; duration: 100}
    NumberAnimation{target: immobilizer; property: "opacity"; to: 0.04; duration: 100}


}

SequentialAnimation{
    id: dummyAnimation
    running: false
    loops: Animation.Infinite

    NumberAnimation{target: highBeam; property: "scale"; to: 0; duration: 300}
    NumberAnimation{target: highBeam; property: "visible"; to: 1; duration: 100}
    NumberAnimation{target: highbeam; property:  "opacity"; to: 0.04; duration: 10}
    NumberAnimation{target: highbeam; property:  "x"; to: 590; duration: 10}
    NumberAnimation{target: highbeam; property:  "y"; to: 230; duration: 10}
    //NumberAnimation{target: highbeam; property:  "z"; to: 0; duration: 10}
    NumberAnimation{target: highbeam; property:  "scale"; to: 0.9; duration: 10}
    NumberAnimation{target: highbeam; property:  "opacity"; to: 1; duration: 10}
    NumberAnimation{target: highBeam; property: "scale"; to: 1.8; duration: 2000}
    ParallelAnimation{
        NumberAnimation {target:highbeam; property: "opacity";from: 0.1; to: 1.0 ;loops: 15 }
    }
    NumberAnimation{target: highBeam; property: "scale"; to: 0; duration: 2000}
    NumberAnimation{target: highbeam; property:  "opacity"; to: 0; duration: 100}
    NumberAnimation{target: highbeam; property:  "x"; to: 230; duration: 10}
    NumberAnimation{target: highbeam; property:  "y"; to: 65; duration: 10}
    NumberAnimation{target: highbeam; property:  "scale"; to: 0.4; duration: 10}
    NumberAnimation{target: highBeam; property: "visible"; to: 0; duration: 100}


    NumberAnimation{target: digitalSpeed; property: "opacity"; to: 0; duration: 100}
    NumberAnimation{target: display_gear; property: "opacity"; to: switch(cluster.configurableBackground_index){case 9:0;break;default:1} duration: 100}
    NumberAnimation{target: gear_image; property: "opacity"; to:switch(cluster.configurableBackground_index){case 9:0;break;default:1} duration: 100}
    NumberAnimation{target: skin_9_car; property: "opacity"; to: 1; duration: 200}
    NumberAnimation{target: skin_9_car; property: "scale"; to: 0.3; duration: 2000}


    NumberAnimation{ target:oil; property: "scale"; to: 0; duration: 300}
    NumberAnimation{ target:oil; property: "visible"; to: 1; duration: 100}
    NumberAnimation{ target:low_oil; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:low_oil; property: "x"; to: 580; duration: 10}
    NumberAnimation{ target:low_oil; property: "y"; to: 230; duration: 10}
    //NumberAnimation{target: low_oil; property:  "z"; to: 0; duration: 10}
    NumberAnimation{ target:low_oil; property: "scale"; to: 0.8; duration: 10}
    NumberAnimation{ target:low_oil; property: "opacity"; to: 1; duration: 10}
    NumberAnimation{ target:oil; property: "scale"; to: 1.5; duration: 2000}
    ParallelAnimation{
        NumberAnimation {target:low_oil; property: "opacity";from: 0.1; to: 1.0 ;loops: 15 }
    }
    NumberAnimation{ target:oil; property: "scale"; to: 0; duration: 2000}
    NumberAnimation{ target:low_oil; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:low_oil; property: "x"; to: 540; duration: 10}
    NumberAnimation{ target:low_oil; property: "y"; to: 92; duration: 10}
    NumberAnimation{target: low_oil; property:  "scale"; to:0.45; duration: 10}
    NumberAnimation{ target:oil; property: "visible"; to: 0; duration: 100}


    NumberAnimation{ target:battery; property: "scale"; to: 0; duration: 300}
    NumberAnimation{ target:battery; property: "visible"; to: 1; duration: 100}
    NumberAnimation{ target:battery_low; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:battery_low; property: "x"; to: 615; duration: 10}
    NumberAnimation{ target:battery_low; property: "y"; to: 220; duration: 10}
    //NumberAnimation{target: battery_low; property:  "z"; to: 0; duration: 10}
    NumberAnimation{ target:battery_low; property: "scale"; to: 0.8; duration: 10}
    NumberAnimation{ target:battery_low; property: "opacity"; to: 1; duration: 10}
    NumberAnimation{ target:battery; property: "scale"; to: 1.5; duration: 2000}
    ParallelAnimation{
        NumberAnimation {target:battery_low; property: "opacity";from: 0.1; to: 1.0 ;loops: 15 }
    }
    NumberAnimation{ target:battery; property: "scale"; to: 0; duration: 2000}
    NumberAnimation{ target:battery_low; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:battery_low; property: "x"; to: 820; duration: 10}
    NumberAnimation{ target:battery_low; property: "y"; to: 60; duration: 10}
    NumberAnimation{target: battery_low; property:  "scale"; to: 0.4; duration: 10}
    NumberAnimation{ target:battery; property: "visible"; to: 0; duration: 100}

    NumberAnimation{target: skin_9_car; property: "scale"; to: 0.05; duration: 2000}
    NumberAnimation{target: skin_9_car; property: "opacity"; to: 0; duration: 200}
    NumberAnimation{target: digitalSpeed; property: "opacity"; to:switch(cluster.configurableBackground_index){case 9:1;break;default:0;} duration: 100}
    NumberAnimation{target: display_gear; property: "opacity"; to: 1; duration: 100}
    NumberAnimation{target: gear_image; property: "opacity"; to: 1; duration: 100}

    NumberAnimation{ target:fuelLeak; property: "scale"; to: 0; duration: 300}
    NumberAnimation{ target:fuelLeak; property: "visible"; to: 1; duration: 100}
    NumberAnimation{ target:petrol_indicator; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:petrol_indicator; property: "x"; to: 600; duration: 10}
    NumberAnimation{ target:petrol_indicator; property: "y"; to: 205; duration: 10}
    //NumberAnimation{target: petrol_indicator; property:  "z"; to: 0; duration: 10}
    NumberAnimation{ target:petrol_indicator; property: "scale"; to: 0.6; duration: 10}
    NumberAnimation{ target:petrol_indicator; property: "opacity"; to: 1; duration: 10}
    NumberAnimation{ target:fuelLeak; property: "scale"; to: 1.5; duration: 2000}
    ParallelAnimation{
        NumberAnimation {target:petrol_indicator; property: "opacity";from: 0.1; to: 1.0 ;loops: 15 }
    }
    NumberAnimation{ target:fuelLeak; property: "scale"; to: 0; duration: 2000}
    NumberAnimation{ target:petrol_indicator; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:petrol_indicator; property: "x"; to: 740; duration: 10}
    NumberAnimation{ target:petrol_indicator; property: "y"; to: 38; duration: 10}
    NumberAnimation{target: petrol_indicator; property:  "scale"; to: 0.3; duration: 10}
    NumberAnimation{ target:fuelLeak; property: "visible"; to: 0; duration: 100}


    NumberAnimation{ target:parkinglight; property: "scale"; to: 0; duration: 300}
    NumberAnimation{ target:parkinglight; property: "visible"; to: 1; duration: 100}
    NumberAnimation{ target:parking_light; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:parking_light; property: "x"; to: 580; duration: 10}
    NumberAnimation{ target:parking_light; property: "y"; to: 223; duration: 10}
    //NumberAnimation{ target:parking_light; property:  "z"; to: 0; duration: 10}
    NumberAnimation{ target:parking_light; property: "scale"; to: 0.8; duration: 10}
    NumberAnimation{ target:parking_light; property: "opacity"; to: 1; duration: 10}
    NumberAnimation{ target:parkinglight; property: "scale"; to: 1.5; duration: 2000}
    ParallelAnimation{
        NumberAnimation {target:parking_light; property: "opacity";from: 0.1; to: 1.0 ;loops: 15 }
    }
    NumberAnimation{ target:parkinglight; property: "scale"; to: 0; duration: 2000}
    NumberAnimation{ target:parking_light; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:parking_light; property: "x"; to: 540; duration: 10}
    NumberAnimation{ target:parking_light; property: "y"; to: 92; duration: 10}
    NumberAnimation{ target:parking_light; property:  "scale"; to:0.45; duration: 10}
    NumberAnimation{ target:parkinglight; property: "visible"; to: 0; duration: 100}

    NumberAnimation{ target:brake; property: "scale"; to: 0; duration: 300}
    NumberAnimation{ target:brake; property: "visible"; to: 1; duration: 100}
    NumberAnimation{ target:brakefailure; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:brakefailure; property: "x"; to: 600; duration: 10}
    NumberAnimation{ target:brakefailure; property: "y"; to: 240; duration: 10}
    //NumberAnimation{ target:brakefailure; property:  "z"; to: 0; duration: 10}
    NumberAnimation{ target:brakefailure; property: "scale"; to: 1.4; duration: 10}
    NumberAnimation{ target:brakefailure; property: "opacity"; to: 1; duration: 10}
    NumberAnimation{ target:brake; property: "scale"; to: 1.5; duration: 2000}
    ParallelAnimation{
        NumberAnimation {target:brakefailure; property: "opacity";from: 0.1; to: 1.0 ;loops: 15 }
    }
    NumberAnimation{ target:brake; property: "scale"; to: 0; duration: 2000}
    NumberAnimation{ target:brakefailure; property: "opacity"; to: 0; duration: 10}
    NumberAnimation{ target:brakefailure; property: "x"; to: 540; duration: 10}
    NumberAnimation{ target:brakefailure; property: "y"; to: 92; duration: 10}
    NumberAnimation{ target:brakefailure; property:  "scale"; to:0.45; duration: 10}
    NumberAnimation{ target:brake; property: "visible"; to: 0; duration: 100}



    //NumberAnimation{ target:turnright; property: "visible"; to: 1; duration: 100}

    ParallelAnimation{
        id:indicator
        NumberAnimation{ target:turnright; property: "visible"; to: 1; duration: 10}
        NumberAnimation {target:turn_right; property: "opacity";from: 0.1; to: 1.0 ;loops: 30 }

    }

    NumberAnimation{ target:turnright; property: "visible"; to: 0; duration: 10}
    NumberAnimation {target:turn_right; property: "opacity";to: 0 ;loops: 30 }


    //NumberAnimation{ target:turnleft; property: "visible"; to: 1; duration: 100}
    ParallelAnimation{
        id:indicator1
        NumberAnimation{ target:turnleft; property: "visible"; to: 1; duration: 300}
        NumberAnimation {target:turn_left; property: "opacity";from: 0.1; to: 1.0 ;loops: 30 }
    }

    NumberAnimation{ target:turnleft; property: "visible"; to: 0; duration: 300}
    NumberAnimation {target:turn_left; property: "opacity";to: 0 ;loops: 30 }

}





}
}

