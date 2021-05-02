FROM oraclelinux:6

ENV MYORACLELINUX6DOCKER_VERSION build-target
ENV MYORACLELINUX6DOCKER_VERSION latest
ENV MYORACLELINUX6DOCKER_VERSION stable
ENV MYORACLELINUX6DOCKER_IMAGE myoraclelinux6docker


# set install flag manual page
RUN sed -i -e"s/^tsflags=nodocs/\# tsflags=nodocs/" /etc/yum.conf

# update all packages
RUN yum -y update && yum clean all

# install wget
RUN yum install -y wget && yum clean all

# setup repo
# see https://docs.oracle.com/cd/E96517_01/ladbi/installing-oracle-linux-with-public-yum-repository-support.html#GUID-190BAEE2-2B77-4AA2-AA6B-5D6AF73A4005 Oracle Linux YumサーバーによるOracle Linuxのインストールのサポート
RUN wget http://yum.oracle.com/public-yum-ol6.repo -O /etc/yum.repos.d/public-yum-ol6.repo

# update all packages
RUN yum -y update && yum clean all

# set locale to Japanese
# RUN localedef -i ja_JP -f UTF-8 ja_JP.UTF-8
# RUN echo 'LANG="ja_JP.UTF-8"' >  /etc/locale.conf
# ENV LANG ja_JP.UTF-8

# install man, man-pages
RUN yum -y install man man-pages man-pages-ja && yum clean all

# install tools
RUN yum install -y \
        bash-completion \
        bind-utils \
        connect \
        connect-proxy \
        curl \
        emacs-nox \
        expect \
        gettext \
        git \
        iproute \
        jq \
        lsof \
        make \
        net-tools \
        nmap-ncat \
        openssh-clients \
        openssh-server \
        python-pip \
        stress \
        sudo \
        tcpdump \
        traceroute \
        tree \
        unzip \
        vim \
        w3m \
        wget \
        zip \
    && yum clean all




ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN /bin/chmod +x /usr/local/bin/docker-entrypoint.sh

ADD bashrc /root/.bashrc
ADD bash_profile /root/.bash_profile
ADD emacsrc /root/.emacs
ADD vimrc /root/.vimrc
ADD bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh

ENV HOME /root
ENV ENV $HOME/.bashrc

# add sudo user
# https://qiita.com/iganari/items/1d590e358a029a1776d6 Dockerコンテナ内にsudoユーザを追加する - Qiita
# ユーザー名 oracle
# パスワード hogehoge
RUN groupadd -g 1000 oracle && \
    useradd  -g      oracle -G wheel -m -s /bin/bash oracle && \
    echo 'oracle:hogehoge' | chpasswd && \
    echo 'Defaults visiblepw'            >> /etc/sudoers && \
    echo 'oracle ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# use normal user oracle
# USER oracle

CMD ["/usr/local/bin/docker-entrypoint.sh"]

