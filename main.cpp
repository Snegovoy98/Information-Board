#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "weatherparser.h"
#include <QQmlContext>
#include <QIcon>



int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QIcon icon(":/resources/logo/logo.png");

    app.setWindowIcon(icon);

    std::unique_ptr<WeatherParser> parser = std::make_unique<WeatherParser>();

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("Weather", parser.get());
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
