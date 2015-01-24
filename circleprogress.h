#ifndef CIRCLEPROGRESS_H
#define CIRCLEPROGRESS_H

#include <QQuickPaintedItem>
#include <QPainter>
#include <qmath.h>

class CircleGraph : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(int endValue READ endValue WRITE setEndValue NOTIFY endValueChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor)
    Q_PROPERTY(int startAngle READ startAngle WRITE setstartAngle)
    Q_PROPERTY(int spanAngle READ spanAngle WRITE setspanAngle)
    Q_PROPERTY(bool multicolor READ multicolor WRITE setmulticolor NOTIFY multicolorChanged)

public:
    explicit CircleGraph(QQuickItem *parent = 0);

    void paint(QPainter *painter);

    QColor color() const;
    int startAngle() const;
    int startValue() const;
    int spanAngle() const;
    int endValue() const;

    Q_INVOKABLE int endValueFromPoint(qreal x = 0, qreal y = 0);

    bool multicolor() const;

protected slots:
    void setmulticolor(bool arg);

signals:
    void endValueChanged(int arg);
    void multicolorChanged(bool arg);

private:
    int m_spanAngle;
    int m_startAngle;
    int m_endValue;
    int m_offset;


    QColor m_color;
    qreal m_scale;

    bool m_multicolor;

    QList<QColor> m_rpm_pieColors;

protected slots:
    void setColor(QColor arg);
    void setstartAngle(int args);
    void setEndValue(int arg);
    void setspanAngle (int arg);
};


#endif // CIRCLEPROGRESS_H
