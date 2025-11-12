# rootfs-custom-winlator
winlator 11 定制版rootfs

# 声明

任何修改的winlator第三方版本在分发时（非个人使用的分发版本）在内置此项目相关文件后务必声明此仓库链接在发布时或应用内以便于修复

Any modified third-party versions of Winlator distributed (i.e., distribution versions not for personal use) must declare the link to this repository upon release or within the application after incorporating files related to this project, in order to facilitate fixes.

# 使用

无论你使用任何修改版本（Winlator 11 beta+ 其他版本未测试），只需要替换掉apk包assets文件夹内的```rootfs.tzst```文件就能享受相比于原版更好的解码效果，如果你不想破坏改版的rootfs结构，请自行解包并解压此仓库Releases的```output-full.tar.xz```(包含了完整的时区文件与所有语言的utf-8编码，但可能没有GBK之类的**特定语言编码**) 或者```output-lite.tar.xz```（不再包含编码与时区文件）到rootfs，然后再使用```zstd```来压缩为rootfs.tzst并自行添加到apk里面

安装完成后无需重装(除非你重新签名导致安装包发生冲突)
在Winlator主界面，点击左上角菜单，⚙️设置(Setting)=> 滑动到页面最底部=> 重新安装文件系统(Reinstall System Files) => 等待进度条跑完 => 完成！😄

可能需要创建一个容器进行测试，要不然貌似不会创建libGL.so.1的链接

然后你就可以愉快的启动容器来测试解码效果了

# Gstreamer解码调试

声明变量```GST_DEBUG```值为```4```，如果没有输出则是调用其他解码，请在调试中✓上```quartz```,```mfplat```或```dxva2```

# 关于视频解码

对于unityH264游戏，经过测试此版本已经可以相当流畅的播放和解码h264视频而不出现卡顿卡死或者黑屏现象，包括*声音*也是正常的，但是在此之前你必须使用原版自带的wine并在环境变量设置里启用```WINE_DO_NOT_CREATE_DXGI_DEVICE_MANAGER```这个变量，如果没有请自行添加，值为**1**，此变量只存在原版和应用相关补丁的wine，请关注我的[**wine-winlator**](https://github.com/Waim908/wine-winlator)仓库，后续会推出相应的版本

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
  -Dgst-plugins-base:gl=disabled \
  -Dgst-plugins-base:opus=disabled \
  -Dgst-plugins-bad:androidmedia=disabled \
  -Dgst-plugins-bad:rtmp=disabled \
  -Dgst-plugins-bad:shm=disabled \
  -Dgst-plugins-bad:zbar=disabled \
  -Dgst-plugins-bad:webp=disabled \
  -Dgst-plugins-bad:kms=disabled \
  -Dgst-plugins-bad:vulkan=disabled \
  -Dgst-plugins-bad:dash=disabled \
  -Dgst-plugins-bad:analyticsoverlay=disabled \
  -Dgst-plugins-bad:nvcodec=disabled \
  -Dgst-plugins-bad:uvch264=disabled \
  -Dgst-plugins-bad:v4l2codecs=disabled \
  -Dgst-plugins-bad:udev=disabled \
  -Dgst-plugins-bad:libde265=disabled \
  -Dgst-plugins-bad:smoothstreaming=disabled \
  -Dgst-plugins-bad:fluidsynth=disabled \
  -Dgst-plugins-bad:inter=disabled \
  -Dgst-plugins-bad:x11=enabled \
  -Dgst-plugins-bad:gl=disabled \
  -Dgst-plugins-bad:wayland=disabled \
  -Dgst-plugins-bad:openh264=disabled \
  -Dgst-plugins-bad:hip=disabled \
  -Dgst-plugins-bad:aja=disabled \
  -Dgst-plugins-bad:aes=disabled \
  -Dgst-plugins-bad:dtls=disabled \
  -Dgst-plugins-bad:hls=disabled \
  -Dgst-plugins-bad:curl=disabled \
  -Dgst-plugins-bad:opus=disabled \
  -Dgst-plugins-bad:webrtc=disabled \
  -Dgst-plugins-bad:webrtcdsp=disabled \
  -Dpackage-origin="[rootfs-custom-winlator](https://github.com/Waim908/rootfs-custom-winlator)" \
  --prefix=/data/data/com.winlator/files/rootfs/
```

## MangoHud
```bash
meson setup builddir \
  -Dwith_xnvctrl=disabled \
  -Dwith_wayland=disabled \
  -Dwith_nvml=disabled \
  -Dinclude_doc=false
  --prefix=/data/data/com.winlator/files/rootfs/
```
depend =>
- ## libxkbcommon
```bash
meson setup builddir \
  -Denable-xkbregistry=false \
  -Denable-bash-completion=false \
  -Denable-wayland=false \
  -Denable-tools=false \
  -Denable-bash-completion=false \
  --prefix=/data/data/com.winlator/files/rootfs/
```

# CA证书支持

[Mozllia证书](https://curl.haxx.se/ca/cacert.pem)

# 测试

bilibili:

[Waim放弃](https://space.bilibili.com/483380143)

# 其他

[data.tar.zst=>全语言utf8编码文件(ubuntu)](http://ports.ubuntu.com/pool/universe/g/glibc/locales-all_2.39-0ubuntu8.6_arm64.deb)

[tzdata-2025b-1-aarch64.pkg.tar.xz=>全时区文件(archlinxu)](https://eu.mirror.archlinuxarm.org/aarch64/core/tzdata-2025b-1-aarch64.pkg.tar.xz)

# 感谢

[hostei2-winlator修改版，支持终端方便调试](https://space.bilibili.com/39433311)

[winlator](https://github.com/brunodev85/Winlator)

[termux-package](https://github.com/termux/termux-packages)

# 补全使用的项目

[gstreamer](https://github.com/GStreamer/gstreamer)

[MangoHud](https://github.com/flightlessmango/MangoHud)

[xz](https://github.com/tukaani-project/xz)

[xkbcommon](https://github.com/xkbcommon/libxkbcommon)