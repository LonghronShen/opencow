project(simple CXX)

add_executable(simple WIN32 "${CMAKE_CURRENT_LIST_DIR}/simple.cpp")

target_compile_definitions(simple
    PRIVATE "_UNICODE"
    PRIVATE "UNICODE"
)

target_link_libraries(simple PRIVATE opencow)

if(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
    target_link_options(simple
        PRIVATE -municode
        PRIVATE -nodefaultlibs
        PRIVATE -nostdlib
        PRIVATE -static-libgcc
        PRIVATE -static-libstdc++
    )
endif()
