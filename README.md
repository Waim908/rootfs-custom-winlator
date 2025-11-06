# rootfs-custom-winlator
winlator 11 定制版rootfs

# 参数

<!-- ### FLAC
```bash
cmake .. \
-Dprefix=/data/data/com.winlator/files/rootfs/ \
-DBUILD_PROGRAMS=off \
-DBUILD_EXAMPLES=off \
-DBUILD_TESTING=off \
-DBUILD_DOCS=off \
-DBUILD_SHARED_LIBS=on \
-DINSTALL_MANPAGES=off
``` -->
FLAC与OPUS均可以通过libav代替

## gstreamer
```bash
meson setup builddir \
  --buildtype=release \
  --strip \
  -Dgst-full-target-type=shared_library \
  -Dintrospection=disabled \
  -Dgst-full-libraries=app,video,player \
  -Dbase=enabled \
  -Dgood=enabled \
  -Dbad=enabled \
  -Dugly=enabled \
  -Dlibav=enabled \
  -Dtests=disabled \
  -Dexamples=disabled \
  -Ddoc=disabled \
  -Dges=disabled \
  -Dpython=disabled \
  -Ddevtools=disabled \
  -Dgstreamer:check=disabled \
  -Dgstreamer:benchmarks=disabled \
  -Dgstreamer:libunwind=disabled \
  -Dgstreamer:libdw=disabled \
  -Dgstreamer:bash-completion=disabled \
  -Dgst-plugins-good:cairo=disabled \
  -Dgst-plugins-good:gdk-pixbuf=disabled \
  -Dgst-plugins-good:oss=disabled \
  -Dgst-plugins-good:oss4=disabled \
  -Dgst-plugins-good:v4l2=disabled \
  -Dgst-plugins-good:aalib=disabled \
  -Dgst-plugins-good:jack=disabled \
  -Dgst-plugins-good:pulse=enabled \
  -Dgst-plugins-good:adaptivedemux2=disabled \
  -Dgst-plugins-good:v4l2=disabled \
  -Dgst-plugins-good:libcaca=disabled \
  -Dgst-plugins-good:mpg123=enabled \
  -Dgst-plugins-base:examples=disabled \
  -Dgst-plugins-base:alsa=enabled \
  -Dgst-plugins-base:pango=disabled \
  -Dgst-plugins-base:x11=enabled \
  -Dgst-plugins-base:gl=enabled \
  -Dgst-plugins-base:gl_api=opengl \
  -Dgst-plugins-base:gl_platform=glx \
  -Dgst-plugins-base:opus=disabled \
  -Dgst-plugins-bad:androidmedia=disabled \
  -Dgst-plugins-bad:rtmp=disabled \
  -Dgst-plugins-bad:shm=disabled \
  -Dgst-plugins-bad:zbar=disabled \
  -Dgst-plugins-bad:webp=disabled \
  -Dgst-plugins-bad:kms=disabled \
  -Dgst-plugins-bad:vulkan=enabled \
  -Dgst-plugins-bad:vulkan-windowing=x11 \
  -Dgst-plugins-bad:vulkan-video=enabled \
  -Dgst-plugins-bad:dash=disabled \
  -Dgst-plugins-bad:analyticsoverlay=disabled \
  -Dgst-plugins-bad:nvcodec=disabled \
  -Dgst-plugins-bad:uvch264=disabled \
  -Dgst-plugins-bad:v4l2codecs=disabled \
  -Dgst-plugins-bad:udev=disabled \
  -Dgst-plugins-bad:libde265=enabled \
  -Dgst-plugins-bad:smoothstreaming=disabled \
  -Dgst-plugins-bad:fluidsynth=disabled \
  -Dgst-plugins-bad:inter=disabled \
  -Dgst-plugins-bad:x11=enabled \
  -Dgst-plugins-bad:gl=diabled \
  -Dgst-plugins-bad:wayland=disabled \
  -Dgst-plugins-bad:openh264=disabled \
  -Dgst-plugins-bad:hip=disabled \
  -Dgst-plugins-bad:aja=disabled \
  -Dgst-plugins-bad:aes=disabled \
  -Dgst-plugins-bad:dtls=disabled \
  -Dgst-plugins-bad:hls=diabled \
  -Dgst-plugins-bad:curl=disabled \
  -Dgst-plugins-bad:opus=disabled \
  -Dpackage-origin="[gstremaer-build] (https://github.com/Waim908/gstreamer-build)" \
  --prefix=/data/data/com.winlator/files/rootfs/
```

# CA证书支持

[Mozllia证书](https://curl.haxx.se/ca/cacert.pem)

# 其他

[data.tar.zst=>全编码文件(ubuntu)](http://archive.ubuntu.com/ubuntu/pool/universe/g/glibc/locales-all_2.39-0ubuntu8.6_amd64.deb)

[tzdata-2025b-1-aarch64.pkg.tar.xz=>全时区文件(archlinxu)](https://eu.mirror.archlinuxarm.org/aarch64/core/tzdata-2025b-1-aarch64.pkg.tar.xz)

# 感谢

[winlator](https://github.com/brunodev85/Winlator)


# 补全使用的项目

[gstreamer](https://github.com/GStreamer/gstreamer)
[xz](https://github.com/tukaani-project/xz)
[vorbis](https://github.com/xiph/vorbis)