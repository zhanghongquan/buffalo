# ---- Declare library ----

add_library(
    buffalo_lib OBJECT
    lib.cpp
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

add_executable(buffalo_exe main.cpp)
add_executable(buffalo::exe ALIAS buffalo_exe)

set_property(TARGET buffalo_exe PROPERTY OUTPUT_NAME buffalo)

target_compile_features(buffalo_exe PRIVATE cxx_std_17)

target_link_libraries(buffalo_exe PRIVATE buffalo_lib)