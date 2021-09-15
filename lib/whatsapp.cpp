#include "whatsapp.h"
#include <QDir>
#include <QUrl>
#include <QFile>
#include <QDebug>
#include <QStandardPaths>
#include <QIODevice>

namespace paths {
    QString device_home = QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation);
    QString data_home = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation);
    QString wsp_cache = "";
    QString ssp_cache = "";

    QString whatsapp_status_path(){
        // androis 10 and up

        if (wsp_cache!="") return wsp_cache;

        QString p = QDir::cleanPath(device_home+"/Android/media/com.whatsapp/WhatsApp/Media/.Statuses");

        qDebug() << "Android 10+ path: " << p;

        if (! QDir(p).exists()){
            // android 9 and below
            p = QDir::cleanPath(device_home+"/WhatsApp/Media/.Statuses");
        }

        qDebug() << "Whatsapp path: " << p;
        wsp_cache = p;
        return p;
    }

    QString status_saver_path(){
        if (ssp_cache!="") return ssp_cache;

        QString p {QDir::cleanPath(data_home)};
        if (! QDir(p).exists()) QDir().mkdir(p);

        // this is the actual status saving path
        p = QDir::cleanPath(p+"/Statuses");
        if (! QDir(p).exists()) QDir().mkdir(p);

        qDebug() << p;
        ssp_cache = p;
        return p;
    }
}

Whatsapp::Whatsapp(QObject *parent) : QObject(parent){
    filters << "*.mp4" << "*.jpg" << "*.jpeg" << "*.png" << "*.gif" << ".avi";
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
