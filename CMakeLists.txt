cmake_minimum_required(VERSION 3.21)

project(Information-Board VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick REQUIRED)

set(PROJECT_SOURCES
        main.cpp
        weatherparser.cpp
        qml.qrc
)

set(app_icon_resource_windows "${CMAKE_CURRENT_SOURCE_DIR}/logo.rc")

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(Information-Board
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
        ${app_icon_resource_windows}
    )
else()
   add_executable(Information-Board
       ${PROJECT_SOURCES}
   )
endif()

target_compile_definitions(Information-Board
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(Information-Board
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick)

set_target_properties(Information-Board PROPERTIES
    WIN32_EXECUTABLE true
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(Information-Board)
    qt_finalize_executable(Information-Board)
endif()

set(COMPONENT_NAME_MAIN "Information-Board")
set(COMPONENT_NAME_DEPENDECIES "RuntimeLibs")

include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT ${COMPONENT_NAME_MAIN})

set(CMAKE_INSTALL_SYSTEM_RUNTIME_COMPONENT ${COMPONENT_NAME_DEPENDENCIES})
include(InstallRequiredSystemLibraries)

set(CPACK_GENERATOR "IFW")
set(CPACK_IFW_ROOT "C:/Qt/QtIFW-4.3.0")
set(CPACK_IFW_PACKAGE_NAME "Information Board")
set(CPACK_IFW_PACKAGE_TITLE "Information Board")
set(CPACK_IFW_PACKAGE_PUBLISHER "Alex Snegovoy")
set(CPACK_IFW_PACKAGE_WINDOW_ICON "${CMAKE_CURRENT_SOURCE_DIR}/logo.png")
set(CPACK_IFW_PACKAGE_ICON "${CMAKE_CURRENT_SOURCE_DIR}/logo.ico")
set(CPACK_IFW_PACKAGE_WIZARD_STYLE "Aero")
set(CPACK_IFW_PACKAGE_WIZARD_SHOW_PAGE_LIST OFF)

set(CPACK_RESOURCES_FILE_LICENSE ${CMAKE_CURRENT_SOURCE_DIR}/../Information-Board-Installer/license.txt)

find_program(WINDEPLOYQT windeployqt HINTS "${_qt_bin_dir}")
configure_file("${CMAKE_CURRENT_SOURCE_DIR}/deploy-qt-windows.cmake.in" "${CMAKE_CURRENT_SOURCE_DIR}/deploy-qt-windows.cmake" @ONLY)

set(CPACK_PRE_BUILD_SCRIPTS ${CMAKE_CURRENT_SOURCE_DIR}/deploy-qt-windows.cmake)

include(CPack)
include(CPackIFW)

CPACK_ADD_COMPONENT(${COMPONENT_NAME_MAIN})

cpack_ifw_configure_component(
 ${COMPONENT_NAME_MAIN}
 ESSENTIAL
 FORCED_INSTALLATION
 REQUIRES_ADMIN_RIGHTS
 NAME ${CPACK_IFW_PACKAGE_NAME}
 LICENSES "ICS License" ${CPACK_RESOURCES_FILE_LICENSE}
 SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/../Information-Board-Installer/installscript.qs
)
