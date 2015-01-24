#include <QtGui/QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>
#include "circleprogress.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<CircleGraph>("CircleGraph", 1, 0, "CircleGraph");

    QStringList dataList1;
    dataList1.append("Pointer");
    dataList1.append("Skin");
    dataList1.append("Dial");
    dataList1.append("Calander");
    dataList1.append("Rear Camera");
    dataList1.append("Maps");

    QQmlApplicationEngine engine;

    QQmlContext *ctxt1 =engine.rootContext();
    ctxt1->setContextProperty("myMenu", QVariant::fromValue(dataList1));

    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
