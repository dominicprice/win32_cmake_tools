cmake_minimum_required(VERSION 3.11)
project(TestProject)

include(../win32_ensure_vcpkg.cmake)
win32_ensure_vcpkg()
message(STATUS "vcpkg found at ${Z_VCPKG_ROOT_DIR}")

include(../win32_ensure_pkgconfig.cmake)
win32_ensure_pkgconfig()
message(STATUS "pkgconfig found at ${PKG_CONFIG_EXECUTABLE}")