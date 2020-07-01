FROM alpine:3.12

## Alpine needs a user to be set

ARG USER=default
ENV HOME /home/$USER

# install sudo as root
RUN apk add --update sudo

# add new user
RUN adduser -D $USER \
        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
        && chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME


## After setting up a user we can move on

# For Postgres 12, repmgr 5.0.0
RUN sudo apk add repmgr
RUN sudo chmod +r /etc/repmgr.conf

ADD entrypoint.sh /entrypoint.sh
ADD primary.conf /repmgr-primary.conf
ADD standby.conf /repmgr-standby.conf

# using `source` to export all ENV variables
CMD source /entrypoint.sh