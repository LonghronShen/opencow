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
    ${CMAKE_CURRENT_LIST_DIR}/src/*.def
    ${CMAKE_CURRENT_LIST_DIR}/src/*.rc
)

add_library(opencow SHARED ${src})

if(MSVC)
    target_link_options(opencow PRIVATE "/nodefaultlib")
endif()

target_include_directories(opencow
    PRIVATE ${CMAKE_CURRENT_LIST_DIR}/src
    PUBLIC ${CMAKE_CURRENT_LIST_DIR}/include
)

target_compile_definitions(opencow
    PRIVATE "_CRT_SECURE_NO_WARNINGS"
    PRIVATE "_CRT_NONSTDC_NO_DEPRECATE"
    PRIVATE "_TIMESPEC_DEFINED"
    PRIVATE "_WIN32_WINNT=0x0400"
    PRIVATE "_LIB"
    PUBLIC "_UNICODE"
    PUBLIC "UNICODE"
)

set_target_properties(opencow PROPERTIES PREFIX "")

add_executable(simple "${CMAKE_CURRENT_LIST_DIR}/tests/simple/simple.cpp")

target_link_libraries(simple PRIVATE opencow)