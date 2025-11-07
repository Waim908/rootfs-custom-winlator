if [[ ! -f /tmp/init.sh ]]; then
  exit 1
else
  source /tmp/init.sh
  echo "gst=> $gstVer"
  echo "vorbis=> $vorbisVer"
  echo "xz=> $xzVer"
fi
mkdir -p /data/data/com.winlator/files/rootfs/
cd /tmp
if ! wget https://github.com/Waim908/rootfs-custom-winlator/releases/download/ori-b11.0/rootfs.tzst; then
	exit 1
fi
tar -xvf rootfs.tzst -C /data/data/com.winlator/files/rootfs/
tar -xvf data.tar.xz -C /data/data/com.winlator/files/rootfs/
tar -xvf tzdata-*-.pkg.tar.xz -C /data/data/com.winlator/files/rootfs/
cd /data/data/com.winlator/files/rootfs/etc
mkdir ca-certificates
if ! wget https://curl.haxx.se/ca/cacert.pem; then
	exit 1
fi
cd /tmp
rm -rf /data/data/com.winlator/files/rootfs/lib/libgst*
rm -rf /data/data/com.winlator/files/rootfs/lib/gstreamer-1.0
#git clone https://github.com/xiph/flac.git flac-src
if ! git clone -b $xzVer https://github.com/tukaani-project/xz.git xz-src; then
  exit 1
fi
if ! git clone  -b $vorbisVer https://github.com/xiph/vorbis.git vorbis-src; then
  exit 1
fi
#git clone https://github.com/xiph/opus.git opus-src
if ! git clone -b $gstVer https://github.com/GStreamer/gstreamer.git gst-src; then
  exit 1
fi

# Build
echo "Build and Compile xz(liblzma)"
cd /tmp/xz-src
./autogen.sh
mkdir build
cd build
if ! ../configure -prefix=/data/data/com.winlator/files/rootfs/; then
  exit 1
fi
if ! make -j$(nproc); then
  exit 1
fi
make install
cd /tmp/vorbis-src
echo "Build and Compile vorbis"
if ! ./autogen.sh; then
  exit 1
fi
if ! ./configure --prefix=/data/data/com.winlator/files/rootfs/; then
  exit 1
fi
if ! make -j$(nproc); then
  exit 1
fi
make install
cd /tmp/gst-src
echo "Build and Compile gstreamer"
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
  -Dpackage-origin="[gstremaer-build] (https://github.com/Waim908/gstreamer-build)" \
  --prefix=/data/data/com.winlator/files/rootfs/
if [[ ! -d builddir ]]; then
  exit 1
fi
if ! meson compile -C builddir; then
  exit 1
fi
meson install -C builddir
# package
echo "Package"
mkdir /tmp/output
cd /data/data/com.winlator/files/rootfs/
if ! tar -I 'zstd -T8' -cvf /tmp/output/rootfs.tzst *; then
  exit 1
fi