#include "serial.h"


#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QIntValidator>
#include <QLineEdit>
#include <QMessageBox>
#include "console.h"
#include <qdebug.h>

SerialLog::SerialLog(QWidget *parent) :
    QMainWindow(parent)
{
    console = new Console;
    m_rpmData=0;
    m_speedData=0;
    console->setEnabled(true);
    setCentralWidget(console);
    getPortInfo();
    serialConsole = new QSerialPort(this);
    serialConsole->setPortName(currentSettings.name);
    serialConsole->setBaudRate(currentSettings.baudRate);
    serialConsole->setDataBits(currentSettings.dataBits);
    serialConsole->setParity(currentSettings.parity);
    serialConsole->setFlowControl(currentSettings.flowControl);
    serialConsole->open(QIODevice::ReadWrite);
    connect( serialConsole, SIGNAL(readyRead()), this, SLOT(readSerialLog()));
    connect(this, SIGNAL(getSpeedData(int)), this, SLOT(setspeedData(int)));
    connect(this, SIGNAL(getRpmData(int)), this, SLOT(setrpmData(int)));
}

SerialLog::~SerialLog()
{
    //delete ui;
}

void SerialLog::openSerialLog(){
    serialConsole->setBaudRate(QSerialPort::Baud115200);
    serialConsole->setDataBits(QSerialPort::Data8);
    serialConsole->setParity(QSerialPort::NoParity);
}


void SerialLog::closeSerialLog(){
    serialConsole->close();
}

void SerialLog::readSerialLog(){
    QByteArray cmprpm= "rpm-";
    QByteArray cmpspd= "spd-";
    qint8 positionV;
    int result;
    QByteArray serialData=  serialConsole->readAll();
    console->putData(serialData);
    if(serialData.contains(cmprpm)||serialData.contains(cmpspd)){

        if(serialData.contains(cmprpm)){
            positionV=serialData.indexOf(cmprpm);
            positionV+=4;
            QByteArray rpmData = serialData.mid(positionV, 3);
            result = rpmData.toInt();
            emit getRpmData(result);
        }
        if(serialData.contains(cmpspd)){
            positionV=serialData.indexOf(cmpspd);
            positionV+=4;
            QByteArray spdData = serialData.mid(positionV, 3);
            result = spdData.toInt();
            emit getSpeedData(result);
        }
    }
    result=0;
    positionV=0;
}

void SerialLog::getPortInfo(){

    static const QString blankString = QObject::tr("N/A");
    QString description;
    QString manufacturer;
    QString serialNumber;
    foreach (const QSerialPortInfo &info, QSerialPortInfo::availablePorts()) {
        QStringList list;
        description = info.description();
        manufacturer = info.manufacturer();
        //serialNumber = info.serialNumber();
        list << info.portName()
             << (!description.isEmpty() ? description : blankString)
             << (!manufacturer.isEmpty() ? manufacturer : blankString)
             << (!serialNumber.isEmpty() ? serialNumber : blankString)
             << info.systemLocation()
             << (info.vendorIdentifier() ? QString::number(info.vendorIdentifier(), 16) : blankString)
             << (info.productIdentifier() ? QString::number(info.productIdentifier(), 16) : blankString);

        currentSettings.name=list.first();
        currentSettings.baudRate = static_cast<QSerialPort::BaudRate>(115200);
        currentSettings.dataBits = static_cast<QSerialPort::DataBits>(8);
        currentSettings.parity = static_cast<QSerialPort::Parity>(0);
        currentSettings.stopBits = static_cast<QSerialPort::StopBits>(1);
        currentSettings.flowControl = static_cast<QSerialPort::FlowControl>(0);

    }

}

int SerialLog::speedData(){
    return m_speedData;
}
int SerialLog::rpmData(){
    return m_rpmData;
}
void SerialLog::setspeedData(const int data)
{
    m_speedData=data;
}

void SerialLog::setrpmData(const int data1){
    m_rpmData=data1;
}

