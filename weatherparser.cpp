#include "weatherparser.h"

WeatherParser::WeatherParser(QObject *parent) : QObject(parent)
{
    networkManager = std::make_unique<QNetworkAccessManager>();
    connect(networkManager.get(), &QNetworkAccessManager::finished, this, [this](QNetworkReply *reply) {
        if(reply->error() == QNetworkReply::NoError)
            emit replyAvailable(QString::fromUtf8(reply->readAll()));
    });
}

void WeatherParser::sendRequest(const QString &url)
{
    networkManager->get(QNetworkRequest(QUrl(url)));
}

