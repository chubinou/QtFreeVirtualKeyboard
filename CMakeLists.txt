# Copyright (c) 2016-2017, EPFL/Blue Brain Project
#                          Raphael Dumusc <raphael.dumusc@epfl.ch>
# Licensed under MIT see LICENSE.MIT in project root

cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(VirtualKeyboard VERSION 1.0.0)
set(VirtualKeyboard_VERSION_ABI 1)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMake/common)
if(NOT EXISTS ${CMAKE_SOURCE_DIR}/CMake/common/Common.cmake)
  message(FATAL_ERROR "CMake/common missing, run: git submodule update --init")
endif()

set(VIRTUALKEYBOARD_DESCRIPTION "A QML based on screen virtual keyboard for embedded QML applications")
set(VIRTUALKEYBOARD_MAINTAINER "Blue Brain Project <bbp-open-source@googlegroups.com>")
set(VIRTUALKEYBOARD_LICENSE MIT)
set(VIRTUALKEYBOARD_DEB_DEPENDS qtbase5-dev qtbase5-private-dev
  qtdeclarative5-dev qtdeclarative5-private-dev)
set(VIRTUALKEYBOARD_PORT_DEPENDS qt5)

include(Common)

common_find_package(Qt5Core REQUIRED)
common_find_package(Qt5Gui REQUIRED COMPONENTS Private)
common_find_package(Qt5Qml REQUIRED)
common_find_package(Qt5Quick REQUIRED COMPONENTS Private)
common_find_package_post()

add_subdirectory(src)

option(VIRTUALKEYBOARD_DEMO "Build the VirtualKeyboard demo application" OFF)
if(VIRTUALKEYBOARD_DEMO)
  add_subdirectory(examples/qmlapp)
endif()

include(CommonPackageConfig)
