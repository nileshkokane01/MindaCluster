#include <QtGui/QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>
#include "circleprogress.h"
#include "serial.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<CircleGraph>("CircleGraph", 1, 0, "CircleGraph");
    qmlRegisterType<SerialLog>("serial", 1, 0, "serialdata");


    QStringList dataList1;
    dataList1.append("Skin");
    dataList1.append("Pointer");
    dataList1.append("Dial");
    dataList1.append("Calander");
    dataList1.append("Rear Camera");
    dataList1.append("Maps");
    dataList1.append("Serial Input");
    dataList1.append("Dummy Input");

    QQmlApplicationEngine engine;

    QQmlContext *ctxt1 =engine.rootContext();
    ctxt1->setContextProperty("myMenu", QVariant::fromValue(dataList1));


    QApplication a(argc, argv);
    SerialLog w;
    engine.rootContext()->setContextProperty("w", &w);
    w.show();



    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
