# Copyright (c) 2016, EPFL/Blue Brain Project
#                     Raphael Dumusc <raphael.dumusc@epfl.ch>
# Licensed under MIT see LICENSE.MIT in project root

set(VIRTUALKEYBOARDDEMO_SOURCES
  main.cpp
  qmlappdemo.qrc
)

set(VIRTUALKEYBOARDDEMO_LINK_LIBRARIES Qt5::Qml Qt5::Quick)

common_application(virtualKeyboardDemo)
