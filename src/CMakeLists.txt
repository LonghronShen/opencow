project(opencow C CXX)

if(NOT WIN32)
    message(FATAL_ERROR "Unsupported platform detected")
endif()

file(GLOB_RECURSE src
    ${CMAKE_CURRENT_LIST_DIR}/impl/*.c
    ${CMAKE_CURRENT_LIST_DIR}/impl/*.cpp
    ${CMAKE_CURRENT_LIST_DIR}/impl/*.h
    ${CMAKE_CURRENT_LIST_DIR}/impl/*.def
    ${CMAKE_CURRENT_LIST_DIR}/impl/*.rc
)

include(WinCompat)

add_library(opencow SHARED ${src})

target_include_directories(opencow
    PRIVATE ${CMAKE_CURRENT_LIST_DIR}/impl
    PUBLIC ${CMAKE_CURRENT_LIST_DIR}/include/public
)

target_compile_definitions(opencow
    PRIVATE "_CRT_SECURE_NO_WARNINGS"
    PRIVATE "_CRT_NONSTDC_NO_DEPRECATE"
    PRIVATE "_TIMESPEC_DEFINED"
    PRIVATE "_WIN32_WINNT=0x0400"
    PRIVATE "_LIB"
    PRIVATE "WIN32"
    PRIVATE "_MBCS"
    PRIVATE "_USRDLL"
    PRIVATE "OPENCOW_EXPORTS"
)

if(MSVC)
    add_wincompat(opencow)

    set_property(TARGET opencow PROPERTY
        MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

    target_compile_options(opencow
        PRIVATE /Gm
        PRIVATE /GX
        PRIVATE /ZI
        PRIVATE /GR-
        PRIVATE /c
    )

    target_link_options(opencow
        PRIVATE /SAFESEH:NO
        PRIVATE /FORCE
        PRIVATE /subsystem:console,4.0
    )
elseif(CMAKE_CXX_IS_CLANG_WIN)
    target_link_options(opencow
        PRIVATE -Xlinker "/subsystem:console,4.0"
        # PRIVATE "-Xlinker /force"
        # PRIVATE -Wl,-nodefaultlib
    )

    add_wincompat(opencow)
elseif(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
    target_compile_options(opencow
        PRIVATE -static-libgcc
        PRIVATE -static-libstdc++
        PRIVATE -Wl,--enable-stdcall-fixup
    )

    target_link_options(opencow
        # PRIVATE -nodefaultlibs
        # PRIVATE -nostdlib
        PRIVATE -static-libgcc
        PRIVATE -static-libstdc++
    )
endif()

set_target_properties(opencow PROPERTIES PREFIX "")
