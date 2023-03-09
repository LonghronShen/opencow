find_package(Threads REQUIRED)

include(FetchContent)
include(CheckIncludeFileCXX)

cmake_policy(SET CMP0097 NEW)

if(CMAKE_CXX_IS_CLANG_WIN)
    # winpthreads
    FetchContent_Declare(winpthreads
        GIT_REPOSITORY https://github.com/LonghronShen/winpthreads.git
        GIT_TAG master
        GIT_SHALLOW TRUE
        GIT_SUBMODULES "")

    FetchContent_GetProperties(winpthreads)
    if(NOT winpthreads_POPULATED)
        FetchContent_Populate(winpthreads)
        add_subdirectory(${winpthreads_SOURCE_DIR} ${winpthreads_BINARY_DIR} EXCLUDE_FROM_ALL)
    endif()

    # libcxx
    FetchContent_Declare(libcxx
        GIT_REPOSITORY https://github.com/enlyze/libcxx.git
        GIT_TAG da422159b0fbb47815b4922ca15e77afe10d8fea
        GIT_SHALLOW TRUE
        GIT_SUBMODULES "")

    FetchContent_GetProperties(libcxx)
    if(NOT libcxx_POPULATED)
        FetchContent_Populate(libcxx)
        file(COPY "${CMAKE_CURRENT_LIST_DIR}/patches/libcxx/" DESTINATION "${libcxx_SOURCE_DIR}/")
        add_subdirectory(${libcxx_SOURCE_DIR} ${libcxx_BINARY_DIR} EXCLUDE_FROM_ALL)
    endif()


    # EnlyzeWinCompatLib
    FetchContent_Declare(enlyze_win_compat_lib
        GIT_REPOSITORY https://github.com/enlyze/EnlyzeWinCompatLib.git
        GIT_TAG clang
        GIT_SHALLOW TRUE
        GIT_SUBMODULES "")

    FetchContent_GetProperties(enlyze_win_compat_lib)
    if(NOT enlyze_win_compat_lib_POPULATED)
        FetchContent_Populate(enlyze_win_compat_lib)
        file(COPY "${CMAKE_CURRENT_LIST_DIR}/patches/EnlyzeWinCompatLib/CMakeLists.txt" DESTINATION "${enlyze_win_compat_lib_SOURCE_DIR}/")
        add_subdirectory(${enlyze_win_compat_lib_SOURCE_DIR} ${enlyze_win_compat_lib_BINARY_DIR} EXCLUDE_FROM_ALL)
    endif()
endif()