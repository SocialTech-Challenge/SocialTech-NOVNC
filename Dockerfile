FROM  javicensaez/acroba_core:1.0

USER root

COPY ./background.png /usr/share/lxde/wallpapers/fondo.png

RUN /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN /bin/bash -c "curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -"
RUN sudo apt-get update || echo


RUN rosdep init &&\
    rosdep update --as-root apt:false

RUN sudo apt-get install -y --no-install-recommends build-essential git cmake libasio-dev
RUN sudo apt install -y --no-install-recommends ros-noetic-teleop-twist-keyboard 
RUN sudo apt install -y --no-install-recommends ros-noetic-joint-state-publisher-gui
RUN sudo apt install -y --no-install-recommends ros-noetic-ros-controllers
RUN sudo apt install -y ros-noetic-gmapping
RUN sudo apt install -y ros-noetic-map-server
RUN sudo apt update && apt install -y ssh
RUN sed -ie 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
RUN sed -ie 's/#PermitUserEnvironment no/PermitUserEnvironment yes/g' /etc/ssh/sshd_config
RUN echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config
RUN echo "AcceptEnv FOO" >> /etc/ssh/sshd_config
RUN sed -ri 's/#HostKey \/etc\/ssh\/ssh_host_key/HostKey \/etc\/ssh\/ssh_host_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/etc\/ssh\/ssh_host_rsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_dsa_key/HostKey \/etc\/ssh\/ssh_host_dsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/etc\/ssh\/ssh_host_ed25519_key/g' /etc/ssh/sshd_config
RUN echo "Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,aes192-cbc,aes256-cbc" >> /etc/ssh/sshd_config
RUN echo "LogLevel DEBUG3" >> /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN /usr/bin/ssh-keygen -A
RUN ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key

COPY ./supervisord.conf /etc/supervisord.conf

RUN sudo echo 'root:socialtech' | chpasswd
RUN sudo echo 'ubuntu:ubuntu' | chpasswd

USER ubuntu

RUN /bin/bash -c "git clone --recurse-submodules https://github.com/SocialTech-Challenge/SocialTech_ws" 
                  
RUN /bin/bash -c "cd SocialTech_ws && \
                  git submodule update --recursive --remote"; exit 0

RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
                  cd SocialTech_ws && \
                  catkin_make"

RUN /bin/bash -c "echo 'source /home/ubuntu/SocialTech_ws/devel/setup.bash' >> /home/ubuntu/.bashrc"



