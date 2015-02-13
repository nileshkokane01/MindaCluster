/****************************************************************************
** Meta object code from reading C++ file 'circleprogress.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.3.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "circleprogress.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'circleprogress.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.3.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_CircleGraph_t {
    QByteArrayData data[19];
    char stringdata[187];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_CircleGraph_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_CircleGraph_t qt_meta_stringdata_CircleGraph = {
    {
QT_MOC_LITERAL(0, 0, 11),
QT_MOC_LITERAL(1, 12, 15),
QT_MOC_LITERAL(2, 28, 0),
QT_MOC_LITERAL(3, 29, 3),
QT_MOC_LITERAL(4, 33, 17),
QT_MOC_LITERAL(5, 51, 13),
QT_MOC_LITERAL(6, 65, 8),
QT_MOC_LITERAL(7, 74, 13),
QT_MOC_LITERAL(8, 88, 4),
QT_MOC_LITERAL(9, 93, 11),
QT_MOC_LITERAL(10, 105, 12),
QT_MOC_LITERAL(11, 118, 17),
QT_MOC_LITERAL(12, 136, 1),
QT_MOC_LITERAL(13, 138, 1),
QT_MOC_LITERAL(14, 140, 8),
QT_MOC_LITERAL(15, 149, 5),
QT_MOC_LITERAL(16, 155, 10),
QT_MOC_LITERAL(17, 166, 9),
QT_MOC_LITERAL(18, 176, 10)
    },
    "CircleGraph\0endValueChanged\0\0arg\0"
    "multicolorChanged\0setmulticolor\0"
    "setColor\0setstartAngle\0args\0setEndValue\0"
    "setspanAngle\0endValueFromPoint\0x\0y\0"
    "endValue\0color\0startAngle\0spanAngle\0"
    "multicolor"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_CircleGraph[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       5,   94, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   64,    2, 0x06 /* Public */,
       4,    1,   67,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       5,    1,   70,    2, 0x09 /* Protected */,
       6,    1,   73,    2, 0x09 /* Protected */,
       7,    1,   76,    2, 0x09 /* Protected */,
       9,    1,   79,    2, 0x09 /* Protected */,
      10,    1,   82,    2, 0x09 /* Protected */,

 // methods: name, argc, parameters, tag, flags
      11,    2,   85,    2, 0x02 /* Public */,
      11,    1,   90,    2, 0x22 /* Public | MethodCloned */,
      11,    0,   93,    2, 0x22 /* Public | MethodCloned */,

 // signals: parameters
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::Bool,    3,

 // slots: parameters
    QMetaType::Void, QMetaType::Bool,    3,
    QMetaType::Void, QMetaType::QColor,    3,
    QMetaType::Void, QMetaType::Int,    8,
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::Int,    3,

 // methods: parameters
    QMetaType::Int, QMetaType::QReal, QMetaType::QReal,   12,   13,
    QMetaType::Int, QMetaType::QReal,   12,
    QMetaType::Int,

 // properties: name, type, flags
      14, QMetaType::Int, 0x00495103,
      15, QMetaType::QColor, 0x00095103,
      16, QMetaType::Int, 0x00095003,
      17, QMetaType::Int, 0x00095003,
      18, QMetaType::Bool, 0x00495003,

 // properties: notify_signal_id
       0,
       0,
       0,
       0,
       1,

       0        // eod
};

void CircleGraph::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        CircleGraph *_t = static_cast<CircleGraph *>(_o);
        switch (_id) {
        case 0: _t->endValueChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: _t->multicolorChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 2: _t->setmulticolor((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 3: _t->setColor((*reinterpret_cast< QColor(*)>(_a[1]))); break;
        case 4: _t->setstartAngle((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 5: _t->setEndValue((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: _t->setspanAngle((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 7: { int _r = _t->endValueFromPoint((*reinterpret_cast< qreal(*)>(_a[1])),(*reinterpret_cast< qreal(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 8: { int _r = _t->endValueFromPoint((*reinterpret_cast< qreal(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 9: { int _r = _t->endValueFromPoint();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (CircleGraph::*_t)(int );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&CircleGraph::endValueChanged)) {
                *result = 0;
            }
        }
        {
            typedef void (CircleGraph::*_t)(bool );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&CircleGraph::multicolorChanged)) {
                *result = 1;
            }
        }
    }
}

const QMetaObject CircleGraph::staticMetaObject = {
    { &QQuickPaintedItem::staticMetaObject, qt_meta_stringdata_CircleGraph.data,
      qt_meta_data_CircleGraph,  qt_static_metacall, 0, 0}
};


const QMetaObject *CircleGraph::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *CircleGraph::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_CircleGraph.stringdata))
        return static_cast<void*>(const_cast< CircleGraph*>(this));
    return QQuickPaintedItem::qt_metacast(_clname);
}

int CircleGraph::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QQuickPaintedItem::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 10;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = endValue(); break;
        case 1: *reinterpret_cast< QColor*>(_v) = color(); break;
        case 2: *reinterpret_cast< int*>(_v) = startAngle(); break;
        case 3: *reinterpret_cast< int*>(_v) = spanAngle(); break;
        case 4: *reinterpret_cast< bool*>(_v) = multicolor(); break;
        default: break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setEndValue(*reinterpret_cast< int*>(_v)); break;
        case 1: setColor(*reinterpret_cast< QColor*>(_v)); break;
        case 2: setstartAngle(*reinterpret_cast< int*>(_v)); break;
        case 3: setspanAngle(*reinterpret_cast< int*>(_v)); break;
        case 4: setmulticolor(*reinterpret_cast< bool*>(_v)); break;
        default: break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 5;
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        if (_id < 5)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 5;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void CircleGraph::endValueChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void CircleGraph::multicolorChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
