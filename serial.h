#ifndef SERIAL_H
#define SERIAL_H


#include <QMainWindow>
#include <QtSerialPort/QSerialPort>
#include <QDialog>


class Console;

class SerialLog : public QMainWindow
{
    Q_OBJECT
    Q_PROPERTY(int speedData READ speedData WRITE setspeedData)
    Q_PROPERTY(int rpmData READ rpmData WRITE setrpmData)
public:
    struct Settings {
        QString name;
        qint32 baudRate;
        QSerialPort::DataBits dataBits;
        QSerialPort::Parity parity;
        QSerialPort::StopBits stopBits;
        QSerialPort::FlowControl flowControl;
        bool localEchoEnabled;
    };


    explicit SerialLog(QWidget *parent = 0);
    int speedData();
    int rpmData();
    ~SerialLog();

private :
    void getPortInfo();

signals:
    void getRpmData(const int &data);
    void getSpeedData(const int &data1);

private slots:
    void openSerialLog();
    void closeSerialLog();
    void readSerialLog();
    void setspeedData(const int);
    void setrpmData(const int);

private:

    Console *console;
    Settings currentSettings;
    QSerialPort *serialConsole;
    int m_speedData;
    int m_rpmData;
};



#endif // SERIAL_H
