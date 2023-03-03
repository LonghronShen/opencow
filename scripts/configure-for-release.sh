#!/bin/sh

mkdir -p build.release

cd build.release

exec cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE="$(dirname $0)/cmake/i686-w64-mingw32-toolchain.cmake" ..
exec cmake --build .
