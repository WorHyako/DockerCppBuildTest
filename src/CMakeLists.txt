cmake_minimum_required(VERSION 3.22)

project(dockerQtVtkTest)

set(CMAKE_CXX_STANDARD 17)

find_package(Qt6 COMPONENTS Core Quick LinguistTools Multimedia REQUIRED)

file(GLOB_RECURSE Sources *.cpp)

add_executable(dockerTest main.cpp)
