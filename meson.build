project(
  'QtFreeVirtualKeyboard', 'cpp',
  meson_version: '>=0.47',
  version: '1.0',
  license: 'MIT'
)

pkg = import('pkgconfig')
qt5 = import('qt5')

qt5dep = dependency(
  'qt5',
  modules: ['Core','Gui','Quick', 'Qml', 'QuickControls2', 'QuickWidgets'],
  private_headers: ['Gui', 'Quick', 'Qml'],
)

qt_files = qt5.preprocess(
  qresources: 'src/virtualkeyboard.qrc',
  moc_headers: [
    'src/DeclarativeInputEngine.h',
    'src/VirtualKeyboardInputContext.h',
    'src/VirtualKeyboardInputContextPlugin.h'
  ],
  dependencies: qt5dep
)


extraargs = []
if get_option('default_library') == 'static'
  extraargs += '-DQT_STATICPLUGIN'
else
  extraargs += '-DQT_PLUGIN'
endif


libs = library(
  'qtfreevirtualkeyboard',
  [
    'src/VirtualKeyboardInputContext.cpp',
    'src/VirtualKeyboardInputContextPlugin.cpp',
    'src/DeclarativeInputEngine.cpp',
    qt_files
  ],
  dependencies: [
    qt5dep,
  ],
  cpp_args: extraargs,
  install : true
)

pkg.generate(
  libraries : libs,
  version: meson.project_version(),
  name: 'qtfreevirtualkeyboard',
  description : 'QtFreeVirtualKeyboard',
)
