FROM debian:bookworm

RUN apt update

RUN apt install -y build-essential git doxygen curl
RUN apt install -y \
  cmake \
  libboost-dev \
  libboost-filesystem-dev libboost-regex-dev libboost-system-dev libboost-locale-dev \
  libgoogle-glog-dev \
  libgtest-dev \
  libyaml-cpp-dev \
  libleveldb-dev \
  libmarisa-dev

RUN curl -O https://capnproto.org/capnproto-c++-0.8.0.tar.gz
RUN tar zxf capnproto-c++-0.8.0.tar.gz
WORKDIR capnproto-c++-0.8.0/
RUN ./configure
RUN make -j2 check
RUN make install

RUN git clone https://github.com/BYVoid/OpenCC.git --depth 1
WORKDIR OpenCC/
RUN apt install -y python3
RUN make
RUN make install

WORKDIR /usr/src/gtest
RUN cmake CMakeLists.txt
RUN make
RUN ls -lah
# RUN cp *.a /usr/lib

RUN apt install -y pkg-config

WORKDIR /app
COPY . .
RUN cd librime && make && make install
RUN apt install -y ibus libibus-1.0-dev
RUN apt install -y libnotify-dev
RUN cd plum; make && make install
RUN make
