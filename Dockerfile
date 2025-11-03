FROM alpine:latest

# https://mirrors.alpinelinux.org/
RUN sed -i 's@dl-cdn.alpinelinux.org@ftp.halifax.rwth-aachen.de@g' /etc/apk/repositories

RUN apk update
RUN apk upgrade

# required htop 
RUN apk add --no-cache \
  gcc g++ make linux-headers musl-dev \
  zlib-dev zlib-static python3-dev \
  curl git ncurses-dev ncurses-static libunwind-static libunwind-dev \
  libcap-static libcap-dev flex bison gawk \
  lm-sensors-dev bash xz xz-static git autoconf automake

  
ENV XZ_OPT=-e9
COPY build-static-htop.sh build-static-htop.sh
RUN chmod +x ./build-static-htop.sh
RUN bash ./build-static-htop.sh
