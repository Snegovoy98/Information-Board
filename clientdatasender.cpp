#include "clientdatasender.h"

ClientDataSender::ClientDataSender(QObject *parent):  QObject(parent)
{
    udpSocket = std::make_unique<QUdpSocket>(this);
}

void ClientDataSender::setSelectedSliderImage(const QString &path)
{
    udpSocket->writeDatagram(QByteArray(path.toStdString().c_str()), address, port);
}
