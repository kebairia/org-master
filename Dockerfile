FROM silex/emacs
# FROM org-test
MAINTAINER ZEKE <github.com/kebairia>

ENV LANG=C.UTF-8

# Update the system
RUN apt-get update && \
    apt-get install -y git make && \
    rm -rf /var/lib/apt/lists/*

# RUN xauth add artbox/unix:0  MIT-MAGIC-COOKIE-1  ec315a18fcbcb831dbd98eef471940f8 \
#     && echo "$(cat /etc/os-release)"
COPY ./emacs_config /root/.config/emacs/
COPY ./emacs_config/nano /root/.config/emacs/nano
COPY ./fonts /root/.local/share/fonts
# VOLUME ["./figures","/data/figures"]
# VOLUME ["./lib","/data/lib"]



# WORKDIR /data
CMD ["emacs","q", "--load", "/root/.config/emacs/init.el"]
# CMD ["emacs"]
