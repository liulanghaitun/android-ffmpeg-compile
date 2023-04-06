#!/bin/bash
export ARCH=arm
export CPU=armv7-a
export TARGET=arm-linux-androideabi
export OS=android
export PREFIX=$(pwd)/android/$CPU
export NDK=/opt/android-ndk
export SYSROOT=$NDK/sysroot
export PLATFORM=$NDK/platforms/android-23/arch-arm
export TOOLCHAIN=$NDK/toolchains/$TARGET-4.9/prebuilt/linux-x86_64
export TARGET_TOOCHAIN=$TOOLCHAIN/$TARGET
export CC=$TOOLCHAIN/bin/$TARGET-gcc
export CXX=$TOOLCHAIN/bin/$TARGET-g++
export AR=$TARGET_TOOCHAIN/bin/ar
export AS=$TARGET_TOOCHAIN/bin/as
export LD=$TARGET_TOOCHAIN/bin/ld
export STRIP=$TARGET_TOOCHAIN/bin/strip
export RANLIB=$TARGET_TOOCHAIN/bin/ranlib
export GCCLIB=$TOOLCHAIN/lib/gcc/$TARGET/4.9.x/armv7-a

function load(){
   TARGET_ABI=arm-linux-androideabi ./configure --disable-everything --disable-doc --disable-programs --enable-shared --disable-static --disable-pthreads --enable-cross-compile --arch=$ARCH --cpu=$CPU --target-os=android --enable-pic \
      --prefix=android/armeabi-v7a \
      --enable-encoder=h261 --enable-decoder=h261 --enable-encoder=h263 --enable-decoder=h263 \
      --extra-libs="-lgcc" \
      --extra-cflags="-I$SYSROOT/usr/include -D__ANDROID_API__=23" \
      --extra-ldflags="-rpath-link=$GCCLIB -L$GCCLIB -L$SYSROOT/usr/lib -rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -L. -nostdlib -lc -lm -ldl" \
      --cc=$CC --ld=$LD --strip=$STRIP
}
load
make clean
make -j12
make install
