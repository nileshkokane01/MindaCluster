TEMPLATE = app

QT += qml quick serialport widgets


SOURCES += main.cpp \
    circleprogress.cpp \
    console.cpp \
    serial.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    circleprogress.h \
    serial.h \
    console.h
