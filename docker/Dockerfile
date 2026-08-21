FROM rockylinux:9

RUN dnf update -y
RUN dnf install --setopt=install_weak_deps=False -y https://github.com/warewulf/warewulf/releases/download/v4.7.0/warewulf-4.7.0-1.el8.x86_64.rpm
RUN dnf install -y cpio dnsmasq shim grub2-efi
RUN dnf clean all

RUN ln -s /bin/true /usr/sbin/service
