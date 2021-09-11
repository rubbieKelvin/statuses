#include "whatsapp.h"
#include <QDir>
#include <QUrl>
#include <QFile>
#include <QDebug>
#include <QStandardPaths>
#include <QIODevice>

namespace paths {
    QString device_home = QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation);
    QString data_home = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);

    QString whatsapp_status_path(){
        // androis 10 and up
        QString p = QDir::cleanPath(device_home+"/Andrioid/media/com.whatsapp/WhatsApp/Media/.Statuses");

        if (! QDir(p).exists()){
            // android 9 and below
            p = QDir::cleanPath(device_home+"/WhatsApp/Media/.Statuses");
        }

        qDebug() << "Whatsapp path: " << p;
        return p;
    }

    QString status_saver_path(){
        QString p {QDir::cleanPath(data_home)};
        if (! QDir(p).exists()) QDir().mkdir(p);

        // this is the actual status saving path
        p = QDir::cleanPath(p+"/.statuses");
        if (! QDir(p).exists()) QDir().mkdir(p);

        // create a .nomedia file: to hife media on android
        // and to prevent populating the users gallery
        QFile file(QDir::cleanPath(p+"/.nomedia"));
        if (! file.exists()) file.open(QIODevice::WriteOnly);

        qDebug() << p;
        return p;
    }
}

Whatsapp::Whatsapp(QObject *parent) : QObject(parent){
    filters << "*.mp4" << "*.jpg" << "*.jpeg" << "*.png" << "*.gif";
}


QStringList Whatsapp::getStatuses(){
    QString p = paths::whatsapp_status_path();
    QDir dir(p);

    if (dir.exists()){
        QStringList items = QDir(p).entryList(filters);
        QStringList result;

        for (int i=0; i<items.length(); i++){
            QString filepath = QDir::cleanPath(p + QDir::separator() + items[i]);
            QString fileurl = QUrl::fromLocalFile(filepath).toString();
            result << fileurl;
        }
        return result;
    }else
        return QStringList();
}


void Whatsapp::saveStatus(QUrl url){
    QString name = url.fileName();
    QString newfile = QDir::cleanPath(paths::status_saver_path()+QDir::separator()+name);
    QFile::copy(url.toLocalFile(), newfile);
}

bool Whatsapp::isSaved(QUrl url){
    QString name = url.fileName();
    QString newfile = QDir::cleanPath(paths::status_saver_path()+QDir::separator()+name);
    return QDir().exists(newfile);
}

void Whatsapp::deleteStatus(QUrl url){
    QString name = url.fileName();
    QString newfile = QDir::cleanPath(paths::status_saver_path()+QDir::separator()+name);
    QFile(newfile).remove();
}

QStringList Whatsapp::getSavedStatuses(){
    QString p = paths::status_saver_path();
    QDir dir(p);

    if (dir.exists()){
        QStringList items = QDir(p).entryList(filters);
        QStringList result;

        for (int i=0; i<items.length(); i++){
            QString filepath = QDir::cleanPath(p + QDir::separator() + items[i]);
            QString fileurl = QUrl::fromLocalFile(filepath).toString();
            result << fileurl;
        }
        return result;
    }else
        return QStringList();
}
