FROM alpine:3.5
MAINTAINER Benjamin Henrion <zoobab@gmail.com>

RUN apk update
RUN apk add alpine-sdk bash autoconf gperf bison flex texinfo help2man gawk libtool automake ncurses-dev

ENV user espusb

RUN adduser -h /home/$user -s /bin/sh -D $user
RUN echo "$user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user
RUN chmod 0440 /etc/sudoers.d/$user

USER $user

WORKDIR /home/$user
RUN git clone https://github.com/pfalcon/esp-open-sdk.git
WORKDIR /home/$user/esp-open-sdk
# 03f5e898a059451ec5f3de30e7feff30455f7cec = "Makefile: Make SDK 1.5.4 default"
RUN git checkout 03f5e898a059451ec5f3de30e7feff30455f7cec

USER root
RUN apk add sed wget

USER $user
WORKDIR /home/$user/esp-open-sdk
RUN make
