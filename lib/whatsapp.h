#ifndef WHATSAPP_H
#define WHATSAPP_H

#include <QObject>
#include <QDir>
#include <QUrl>
#include <QStringList>

class Whatsapp : public QObject{
    Q_OBJECT

    public:
        explicit Whatsapp(QObject *parent = nullptr);
        QStringList filters;
        QString status_path;
        QString storage_path;

    public slots:
        QStringList getStatuses();
        void saveStatus(QUrl);
        bool isSaved(QUrl);
        void deleteStatus(QUrl);
        QStringList getSavedStatuses();
};

#endif // WHATSAPP_H
