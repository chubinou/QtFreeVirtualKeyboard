# Copyright (c) 2016, EPFL/Blue Brain Project
#                     Raphael Dumusc <raphael.dumusc@epfl.ch>
# Licensed under MIT see LICENSE.MIT in project root

cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(VirtualKeyboard VERSION 1.0.0)
set(VirtualKeyboard_VERSION_ABI 1)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/CMake
                              ${CMAKE_SOURCE_DIR}/CMake/common)
include(GitExternal)

set(VIRTUALKEYBOARD_DESCRIPTION "A QML based on screen virtual keyboard for embedded QML applications")
set(VIRTUALKEYBOARD_MAINTAINER "Blue Brain Project <bbp-open-source@googlegroups.com>")
set(VIRTUALKEYBOARD_LICENSE MIT)
set(VIRTUALKEYBOARD_DEB_DEPENDS qtbase5-dev qtbase5-private-dev
  qtdeclarative5-dev qtdeclarative5-private-dev)
set(VIRTUALKEYBOARD_PORT_DEPENDS qt5-mac)

include(Common)

common_find_package(Qt5Core REQUIRED)
common_find_package(Qt5Gui REQUIRED COMPONENTS Private)
common_find_package(Qt5Qml REQUIRED)
#common_find_package(Qt5Quick REQUIRED COMPONENTS Private)
# WAR for Ubuntu 14.04 in Jenkins CI
common_find_package(Qt5Quick 5.4 COMPONENTS Private)
if(NOT Qt5Quick_FOUND)
  message(WARNING "Qt5Quick not found, the project will not be built")
  return()
endif()

common_find_package_post()

add_subdirectory(src)

option(VIRTUALKEYBOARD_DEMO "Build the VirtualKeyboard demo application" OFF)
if(VIRTUALKEYBOARD_DEMO)
  add_subdirectory(examples/qmlapp)
endif()

include(CommonPackageConfig)
