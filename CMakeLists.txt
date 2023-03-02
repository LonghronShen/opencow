cmake_minimum_required(VERSION 3.1)

if(NOT WIN32)
    message(FATAL_ERROR "Only available for Win32 platforms.")
endif()

project(opencow C CXX)

if(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
    set(CMAKE_CXX_FLAGS "-Wall")
    set(CMAKE_CXX_FLAGS_DEBUG "-g3")
    set(CMAKE_CXX_FLAGS_RELEASE "-O2 -s")
    set(CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS "-shared -static-libgcc -static-libstdc++ -Wl,--enable-stdcall-fixup")
endif()

file(GLOB_RECURSE src
    ${CMAKE_CURRENT_LIST_DIR}/src/*.c
    ${CMAKE_CURRENT_LIST_DIR}/src/*.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/*.h
)

add_library(opencow SHARED ${src})

target_include_directories(opencow PRIVATE ${CMAKE_CURRENT_LIST_DIR}/src)

set_target_properties(opencow PROPERTIES PREFIX "")

add_executable(simple "${CMAKE_CURRENT_LIST_DIR}/tests/simple/simple.cpp")

target_link_libraries(simple PRIVATE opencow)