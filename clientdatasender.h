#ifndef CLIENTDATASENDER_H
#define CLIENTDATASENDER_H

#include <QObject>
#include <QUdpSocket>

class ClientDataSender : public QObject
{
    Q_OBJECT
public:
    explicit ClientDataSender(QObject *parent = nullptr);

    Q_INVOKABLE void setSelectedSliderImage(const QString &path);

private:
    std::unique_ptr<QUdpSocket> udpSocket;
    QHostAddress address;
    int port;
};

#endif // CLIENTDATASENDER_H
