FROM ubuntu
MAINTAINER ZEK <zek@kebairia.com>

ENV LANG=C.UTF-8

COPY ./ ./
VOLUME ["./figures","/data/figures"]

# Update the system
RUN apt-get update 
# Install required packages
RUN apt-get install -y wget \
    emacs\

WORKDIR /data
