cmake_minimum_required(VERSION 3.12)
project(InstallLibraries)

include(ExternalProject)

# 设置安装目录
set(INSTALL_PREFIX "/home/fu/mylibs")

ExternalProject_Add(
    zlib
    PREFIX zlib
    GIT_REPOSITORY https://github.com/madler/zlib.git
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}/zlib
)


# 安装 dlt-daemon
ExternalProject_Add(
    dlt-daemon
    PREFIX dlt-daemon
    URL https://github.com/COVESA/dlt-daemon/archive/refs/tags/v2.18.10.tar.gz  # 替换为相应的 release 版本
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}/dlt  -DZLIB_ROOT=${INSTALL_PREFIX}/zlib  # 指定 zlib 的路径
     <SOURCE_DIR>
     DEPENDS zlib
)

# # 安装 Poco
# ExternalProject_Add(
#     poco
#     PREFIX poco
#     URL https://github.com/pocoproject/poco/archive/poco-1.10.1-release.tar.xz  # 替换为相应的 release 版本
#     CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}/poco <SOURCE_DIR>
# )

# # 安装 rapidjson
# ExternalProject_Add(
#     rapidjson
#     PREFIX rapidjson
#     URL https://github.com/Tencent/rapidjson/archive/v1.1.0.tar.xz  # 替换为相应的 release 版本
#     CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}/rapidjson <SOURCE_DIR>
# )

# 安装 jansson
ExternalProject_Add(
    jansson
    PREFIX jansson
    URL https://github.com/akheron/jansson/releases/download/v2.14/jansson-2.14.tar.gz  # 替换为相应的 release 版本
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}/jansson <SOURCE_DIR>
)

# 编译和安装所有项目
ExternalProject_Add_StepTargets(dlt-daemon build install)
# ExternalProject_Add_StepTargets(poco build install)
# ExternalProject_Add_StepTargets(rapidjson build install)
ExternalProject_Add_StepTargets(jansson build install)
