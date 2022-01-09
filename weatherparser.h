#ifndef WEATHERPARSER_H
#define WEATHERPARSER_H
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QUrlQuery>
#include <QUrl>
#include <QDebug>

class WeatherParser : public QObject
{
    Q_OBJECT
public:
    explicit WeatherParser(QObject *parent = nullptr);

signals:
 Q_SIGNAL void replyAvailable(const QString &reply);

public slots:
  Q_INVOKABLE void sendRequest(const QString &url);

private:
    std::unique_ptr<QNetworkAccessManager> networkManager;
};

#endif // WEATHERPARSER_H
