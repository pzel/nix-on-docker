FROM debian:wheezy
RUN echo -e 'nameserver 8.8.8.8\nnameserver8.8.4.4\n' > /etc/resolv.conf
RUN apt-get update && apt-get install -y ca-certificates curl bzip2 locales unzip mg openssh-server --no-install-recommends
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
RUN locale-gen

RUN useradd -m -s /bin/bash nnn
RUN echo 'nnn:nnn' | chpasswd
RUN mkdir -p /home/nnn/.ssh
COPY authorized_keys /home/nnn/.ssh/authorized_keys
RUN chown -R nnn:nnn /home/nnn/.ssh
RUN chmod 700 /home/nnn/.ssh
RUN chmod 600 /home/nnn/.ssh/*

RUN touch /etc/default/locale
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale
RUN echo "LANG=en_US.UTF-8" >> /etc/default/locale

COPY bootstrap-nix.sh /home/nnn/bootstrap-nix.sh
RUN chmod +x /home/nnn/bootstrap-nix.sh
RUN mkdir -p /home/nnn/.nixpkgs
COPY config.nix /home/nnn/.nixpkgs/config.nix
RUN chown -R nnn:nnn /home/nnn
RUN mkdir -p /nix && chown -R nnn:nnn /nix

COPY init.sh /bin/init.sh
RUN chmod +x /bin/init.sh
EXPOSE 22

CMD /bin/init.sh & /bin/bash