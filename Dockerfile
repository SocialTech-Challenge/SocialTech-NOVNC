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

USER ubuntu

RUN /bin/bash -c "git clone --recurse-submodules https://github.com/SocialTech-Challenge/SocialTech_ws" 
                  
RUN /bin/bash -c "cd SocialTech_ws && \
                  git submodule update --recursive --remote"; exit 0

RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
                  cd SocialTech_ws && \
                  catkin_make"

RUN /bin/bash -c "echo 'source /home/ubuntu/SocialTech_ws/devel/setup.bash' >> /home/ubuntu/.bashrc"



