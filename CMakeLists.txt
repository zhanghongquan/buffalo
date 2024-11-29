cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    buffalo
    VERSION 0.1.0
    DESCRIPTION "a timeseries data store"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    buffalo_lib OBJECT
    source/lib.cpp
)

target_include_directories(
    buffalo_lib ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source>"
)

target_compile_features(buffalo_lib PUBLIC cxx_std_17)

find_package(fmt REQUIRED)
target_link_libraries(buffalo_lib PRIVATE fmt::fmt)

# ---- Declare executable ----

add_executable(buffalo_exe source/main.cpp)
add_executable(buffalo::exe ALIAS buffalo_exe)

set_property(TARGET buffalo_exe PROPERTY OUTPUT_NAME buffalo)

target_compile_features(buffalo_exe PRIVATE cxx_std_17)

target_link_libraries(buffalo_exe PRIVATE buffalo_lib)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT buffalo_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of buffalo"
  )
endif()

include(cmake/dev-mode.cmake)
