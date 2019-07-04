#include "VirtualKeyboardInputContextPlugin.h"
#include "VirtualKeyboardInputContext.h"
//============================================================================
/// \file   VirtualKeyboardInputContextPlugin.cpp
/// \author Uwe Kindler
/// \date   08.01.2015
/// \brief  Implementation of VirtualKeyboardInputContextPlugin
///
/// Copyright 2015 Uwe Kindler
/// Licensed under MIT see LICENSE.MIT in project root
//============================================================================

//============================================================================
//                                 INCLUDES
//============================================================================
#include <QDebug>

//============================================================================
QPlatformInputContext* VirtualKeyboardInputContextPlugin::create(const QString& system, const QStringList& paramList)
{
    Q_UNUSED(paramList);

#if defined(QT_STATICPLUGIN)
    Q_INIT_RESOURCE(virtualkeyboard);
#endif

    if (system.compare(system, QStringLiteral("virtualkeyboard"), Qt::CaseInsensitive) == 0)
    {
        return VirtualKeyboardInputContext::instance();
    }
    return 0;
}


//------------------------------------------------------------------------------
// EOF VirtualInputContextPlugin.cpp
