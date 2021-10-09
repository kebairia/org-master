FROM silex/emacs
MAINTAINER ZEKE <zek@kebairia.com>

ENV LANG=C.UTF-8
RUN xauth \
&& xauth add artbox/unix:0  MIT-MAGIC-COOKIE-1  52a34e4a8e6ebc256765c76a31a45a84 \
&& echo "$(cat /etc/os-release)"
COPY ./emacs_config ./.emacs.d
VOLUME ["./figures","/data/figures"]
VOLUME ["./lib","/data/lib"]

# Update the system
#RUN apt-get update 
## Install required packages
#RUN apt-get install -y wget \
    #emacs\

WORKDIR /data
ENTRYPOINT ["emacs"]
