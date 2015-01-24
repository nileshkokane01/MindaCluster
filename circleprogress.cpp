
#include "circleprogress.h"
#include "qdebug.h"
#define M_180_D_PI 180/M_PI

CircleGraph::CircleGraph(QQuickItem *parent) :
    QQuickPaintedItem(parent)
{
    m_endValue = 0;
    m_multicolor = false;
    m_scale = 16 / 57.6;
//    m_startAngle = (m_endValue * 57.6) + (1440);
    setAntialiasing(true);
}

void CircleGraph::paint(QPainter *painter)
{
    painter->setPen(Qt::NoPen);
    painter->setBrush(m_color);
    painter->drawPie(boundingRect().adjusted(1, 1, -1, -1), -m_startAngle, m_spanAngle);


}

QColor CircleGraph::color() const
{
    return m_color;
}

int CircleGraph::startAngle() const
{
    return m_startAngle;
}

void CircleGraph::setColor(QColor arg)
{
    m_color = arg;
}

void CircleGraph::setspanAngle(int arg)
{
    m_spanAngle=arg;
}

void CircleGraph::setstartAngle(int args)
{
    m_startAngle=args;
}

int CircleGraph::endValue() const
{
    return m_endValue;
}

int CircleGraph::spanAngle() const
{
    return m_spanAngle;
}

int CircleGraph::endValueFromPoint(qreal x, qreal y)
{
    qreal theta = qAtan2(x,-y);
    qreal angle = fmod((theta * M_180_D_PI) + 360,360);
    int v = qFloor(angle) * m_scale;
    return v;
}

void CircleGraph::setEndValue(int arg)
{
    if (m_endValue != arg) {
        m_endValue = arg;
        m_spanAngle = m_endValue * 57.6;
        emit endValueChanged(arg);
        update();
    }
}

bool CircleGraph::multicolor() const
{
    return m_multicolor;
}

void CircleGraph::setmulticolor(bool arg)
{
    if (m_multicolor != arg) {
        m_multicolor = arg;

        if(m_multicolor)
            m_rpm_pieColors << QColor(235,120,70)
                          << QColor(232,156,132)
                          << QColor(254,197,107)
                          << QColor(81,197,212);

        emit multicolorChanged(arg);

    }
}

