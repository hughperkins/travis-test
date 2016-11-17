cmake_minimum_required(VERSION 2.8)

set(CLANG_HOME "/usr/lib/llvm-3.8" CACHE STRING "eg the downloaded clang-3.8.0 folder, containing lib, bin etc")

set(CMAKE_CC_FLAGS "-fPIC")
# set(LLVM_COMPILE_FLAGS "-fvisibility-inlines-hidden -ffunction-sections -fdata-sections")
set(CMAKE_CXX_FLAGS "-std=c++11 -fPIC ${LLVM_COMPILE_FLAGS}")
add_definitions(-DUSE_CLEW)  # turns off direct linking with libOpenCL.so, all goes via clew dynamic loader (no need to link with libOpenCL at build time)
# for llvm:
# add_definitions(-D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS)

execute_process(
    COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/cmake/llvm-syslibs.sh ${CLANG_HOME}
    OUTPUT_VARIABLE LLVM_SYSLIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/cmake/get-llvm-cxxflags.sh ${CLANG_HOME}
    OUTPUT_VARIABLE LLVM_CXXFLAGS
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
message("LLVM_CXXFLAGS ${LLVM_CXXFLAGS}")
STRING(REGEX REPLACE " " ";" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
message("LLVM_CXXFLAGS ${LLVM_CXXFLAGS}")
string(REGEX REPLACE ";-std=c\\+\\+0x" ";-std=c++11" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
string(REGEX REPLACE ";-fno-exceptions" ";-fexceptions" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
string(REGEX REPLACE ";-DNDEBUG" "" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
string(REGEX REPLACE ";-isysroot;[^;]+" "" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
message("LLVM_CXXFLAGS ${LLVM_CXXFLAGS}")

set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-rpath,$ORIGIN")

execute_process(
    COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/cmake/get-llvm-libs.sh ${CLANG_HOME}
    OUTPUT_VARIABLE LLVM_LIBFILES
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

STRING(REGEX MATCHALL "[^ ]+" LLVM_LIBFILES "${LLVM_LIBFILES}")

foreach(LIB ${LLVM_LIBFILES})
   if(LLVM_LIBS)
   set(LLVM_LIBS ${LLVM_LIBS} ${CLANG_HOME}/lib/${LIB})
   else()
   set(LLVM_LIBS "${CLANG_HOME}/lib/${LIB}")
   endif()
endforeach()

add_executable(test_llvm_valuemap testvaluemap.cpp)
target_include_directories(test_llvm_valuemap PRIVATE ${CLANG_HOME}/include)
target_link_libraries(test_llvm_valuemap  ${LLVM_LIBS} ${LLVM_SYSLIBS})
target_compile_options(test_llvm_valuemap PRIVATE ${LLVM_CXXFLAGS})
