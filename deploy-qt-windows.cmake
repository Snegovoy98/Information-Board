set(WINDEPLOYQT "C:/Qt/6.2.4/mingw_64/bin/windeployqt.exe")
set(COMPONENT_NAME_MAIN "Information-Board")
set(CMAKE_CURRENT_SOURCE_DIR "D:/Projects/Information/Information-Board")

execute_process(COMMAND ${WINDEPLOYQT} --qmldir ${CMAKE_CURRENT_SOURCE_DIR}
${COMPONENT_NAME_MAIN}/data/bin WORKING_DIRECTORY
${CPACK_TEMPORARY_INSTALL_DIRECTORY}/packages)
