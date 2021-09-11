#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "qtstatusbar/src/statusbar.h"
#include "lib/whatsapp.h"

# if defined (Q_OS_ANDROID)
#include <QtAndroid>

//all the permissions we'll need asap
QVector <QString> permmissions {
    QStringLiteral("android.permission.WRITE_EXTERNAL_STORAGE"),
    QStringLiteral("android.permission.READ_EXTERNAL_STORAGE"),
    QStringLiteral("android.permission.INTERNET"),
    QStringLiteral("android.permission.ACCESS_NETWORK_STATE")
};
# endif


int main(int argc, char *argv[]){

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

#if defined (Q_OS_ANDROID)
    // ask for permissions one by one
    for (auto permission: permmissions){

        auto result = QtAndroid::checkPermission(permission);

        if (result == QtAndroid::PermissionResult::Denied){
            auto result_hash = QtAndroid::requestPermissionsSync(QStringList({permission}));

            if (result_hash[permission] == QtAndroid::PermissionResult::Denied) return 0;
        }
    }
#endif

    QGuiApplication app(argc, argv);

    app.setApplicationName("Statuses");
    app.setOrganizationName("stuffsbyrubbie");
    app.setOrganizationDomain("com.stuffsbyrubbie.statuses");

    QQmlApplicationEngine engine;
    Whatsapp wa;

    qmlRegisterType<StatusBar>("StuffsByRubbie", 0, 1, "StatusBar");

    const QUrl url(QStringLiteral("qrc:/uix/main.qml"));
    
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url] (QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("whatsapp", &wa);
    engine.load(url);
    return app.exec();
}
