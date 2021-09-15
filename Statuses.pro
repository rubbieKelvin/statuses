QT += quick svg qml quickcontrols2 core
CONFIG += c++11

unix:android{
QT += androidextras
}

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

include(qtstatusbar/src/statusbar.pri)

SOURCES += \
        lib/whatsapp.cpp \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
	android/AndroidManifest.xml \
	android/AndroidManifest.xml \
	android/build.gradle \
	android/build.gradle \
	android/gradle.properties \
	android/gradle.properties \
	android/gradle/wrapper/gradle-wrapper.jar \
	android/gradle/wrapper/gradle-wrapper.jar \
	android/gradle/wrapper/gradle-wrapper.properties \
	android/gradle/wrapper/gradle-wrapper.properties \
	android/gradlew \
	android/gradlew \
	android/gradlew.bat \
	android/gradlew.bat \
	android/res/values/libs.xml \
	android/res/values/libs.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
	lib/whatsapp.h
