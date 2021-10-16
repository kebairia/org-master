FROM silex/emacs
MAINTAINER ZEKE <zek@kebairia.com>

ENV LANG=C.UTF-8
RUN xauth \
    && xauth add artbox/unix:0  MIT-MAGIC-COOKIE-1  38635c3db97233de72489f7f93c42a4b \
    && echo "$(cat /etc/os-release)"
COPY ./emacs_config /root/.config/emacs/
VOLUME ["./figures","/data/figures"]
VOLUME ["./lib","/data/lib"]

# Update the system
RUN apt-get -y update 
RUN apt-get install -y git


# WORKDIR /data
CMD ["emacs","q", "--load", "~/.config/emacs/init.el"]
# CMD ["emacs"]


