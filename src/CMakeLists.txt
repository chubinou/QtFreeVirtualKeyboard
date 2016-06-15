# Copyright (c) 2016, EPFL/Blue Brain Project
#                     Raphael Dumusc <raphael.dumusc@epfl.ch>
# Licensed under MIT see LICENSE.MIT in project root

list(APPEND VIRTUALKEYBOARD_PUBLIC_HEADERS
  DeclarativeInputEngine.h
  VirtualKeyboardInputContext.h
  VirtualKeyboardInputContextPlugin.h
)

list(APPEND VIRTUALKEYBOARD_SOURCES
  DeclarativeInputEngine.cpp
  VirtualKeyboardInputContext.cpp
  VirtualKeyboardInputContextPlugin.cpp
  virtualkeyboard.qrc
)

set(VIRTUALKEYBOARD_LINK_LIBRARIES
  Qt5::Core
  Qt5::Qml
  Qt5::Quick
  Qt5::Gui
)

add_library(VirtualKeyboard SHARED
  ${VIRTUALKEYBOARD_SOURCES}
  ${VIRTUALKEYBOARD_PUBLIC_HEADERS}
)
target_link_libraries(VirtualKeyboard ${VIRTUALKEYBOARD_LINK_LIBRARIES})
# Private header include directories are not part of the Qt5 CMake targets
target_include_directories(VirtualKeyboard PRIVATE
  ${Qt5Gui_PRIVATE_INCLUDE_DIRS}
  ${Qt5Quick_PRIVATE_INCLUDE_DIRS}
)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set_target_properties(VirtualKeyboard PROPERTIES AUTOMOC TRUE AUTORCC TRUE)
set_target_properties(VirtualKeyboard PROPERTIES COMPILE_DEFINITIONS
  "QT_PLUGIN;QT_SHARED")
set_target_properties(VirtualKeyboard PROPERTIES LIBRARY_OUTPUT_DIRECTORY
  "${CMAKE_BINARY_DIR}/bin/platforminputcontexts")

# For CommonPackageConfig.cmake, as done by CommonLibrary
#list(APPEND ${PROJECT_NAME}Targets VirtualKeyboard)
install(TARGETS VirtualKeyboard
  EXPORT ${PROJECT_NAME}Targets
  LIBRARY DESTINATION bin/platforminputcontexts COMPONENT lib
  INCLUDES DESTINATION include
)
# for DoxygenRule.cmake and SubProject.cmake
set_property(GLOBAL APPEND PROPERTY
             ${PROJECT_NAME}_ALL_DEP_TARGETS VirtualKeyboard)
