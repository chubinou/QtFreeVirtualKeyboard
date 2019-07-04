//============================================================================
/// \file   VirtualKeyboardInputContext.cpp
/// \author Uwe Kindler
/// \date   08.01.2015
/// \brief  Implementation of VirtualKeyboardInputContext
///
/// Copyright 2015 Uwe Kindler
/// Licensed under MIT see LICENSE.MIT in project root
//============================================================================

//============================================================================
//                                 INCLUDES
//============================================================================
#include "VirtualKeyboardInputContext.h"

#include <QDebug>
#include <QEvent>
#include <QGuiApplication>
#include <QQmlEngine>
#include <QQmlContext>
#include <QVariant>
#include <QQmlEngine>
#include <QJSEngine>
#include <QPropertyAnimation>

#include <private/qquickflickable_p.h>
#include "DeclarativeInputEngine.h"


/**
 * Private data class for VirtualKeyboardInputContext
 */
class VirtualKeyboardInputContextPrivate
{
public:
    VirtualKeyboardInputContextPrivate();
    ~VirtualKeyboardInputContextPrivate();
    QQuickFlickable* Flickable;
    QObject* FocusItem;
    bool Visible;
    DeclarativeInputEngine* InputEngine;
};


//==============================================================================
VirtualKeyboardInputContextPrivate::VirtualKeyboardInputContextPrivate()
    : Flickable(0),
      FocusItem(0),
      Visible(false),
      InputEngine(new DeclarativeInputEngine())
{
    QQmlEngine::setObjectOwnership(InputEngine, QQmlEngine::CppOwnership);
}

VirtualKeyboardInputContextPrivate::~VirtualKeyboardInputContextPrivate()
{
   delete InputEngine;
}

//==============================================================================
VirtualKeyboardInputContext::VirtualKeyboardInputContext() :
    QPlatformInputContext(), d(new VirtualKeyboardInputContextPrivate)
{
    qmlRegisterSingletonType<DeclarativeInputEngine>("VirtualKeyboard", 1, 0,
        "InputEngine", inputEngineProvider);
}


//==============================================================================
VirtualKeyboardInputContext::~VirtualKeyboardInputContext()
{
    delete d;
}


//==============================================================================
VirtualKeyboardInputContext* VirtualKeyboardInputContext::instance()
{
    static VirtualKeyboardInputContext* InputContextInstance = new VirtualKeyboardInputContext;
    return InputContextInstance;
}



//==============================================================================
bool VirtualKeyboardInputContext::isValid() const
{
    return true;
}


//==============================================================================
QRectF VirtualKeyboardInputContext::keyboardRect() const
{
    return QRectF();
}


//==============================================================================
void VirtualKeyboardInputContext::showInputPanel()
{
    d->Visible = true;
    QPlatformInputContext::showInputPanel();
    emitInputPanelVisibleChanged();
}


//==============================================================================
void VirtualKeyboardInputContext::hideInputPanel()
{
    d->Visible = false;
    QPlatformInputContext::hideInputPanel();
    emitInputPanelVisibleChanged();
}


//==============================================================================
bool VirtualKeyboardInputContext::isInputPanelVisible() const
{
    return d->Visible;
}


//==============================================================================
bool VirtualKeyboardInputContext::isAnimating() const
{
    return false;
}


//==============================================================================
void VirtualKeyboardInputContext::setFocusObject(QObject *object)
{
    static const int NumericInputHints = Qt::ImhPreferNumbers | Qt::ImhDate
        | Qt::ImhTime | Qt::ImhDigitsOnly | Qt::ImhFormattedNumbersOnly;
    static const int DialableInputHints = Qt::ImhDialableCharactersOnly;

    if (!object)
        return;

    if (d->FocusItem)
        d->FocusItem->removeEventFilter(this);

    d->FocusItem = object;
    d->FocusItem->installEventFilter(this);
}


//==============================================================================
bool VirtualKeyboardInputContext::eventFilter(QObject *object, QEvent *event)
{
    if (object != d->FocusItem)
        return false;
    QEvent::Type type = event->type();
    if ((type == QEvent::KeyPress || type == QEvent::KeyRelease) && isInputPanelVisible())
    {
        const QKeyEvent *keyEvent = static_cast<const QKeyEvent *>(event);
        int key = keyEvent->key();
        if ((key >= Qt::Key_Left && key <= Qt::Key_Down) || key == Qt::Key_Space || key == Qt::Key_Cancel)
        {
            if (type == QEvent::KeyPress)
                emit d->InputEngine->navPressed((Qt::Key)key);
            else
                emit d->InputEngine->navReleased((Qt::Key)key);
            return true;
        }
    }
    return false;
}

//==============================================================================
QObject* VirtualKeyboardInputContext::inputEngineProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return VirtualKeyboardInputContext::instance()->d->InputEngine;
}

//------------------------------------------------------------------------------
// EOF VirtualKeyboardInpitContext.cpp
