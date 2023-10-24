# Contenedor docker para uso en SocialTech-Challenge

Este contenedor contiene todos los ficheros necesarios para poder comenzar a trabajar desde el minuto cero. Al arrancar el contenedor ya se pueden realizar simulaciones, simplemente accediendo mediante un navegador web a la dirección http://127.0.0.1:6080 y utilizando la contraseña mypasswd.

Incluso se puede utilizar desde windows, es necesario contar con una tarjeta gráfica nvidia. Pero para ello es necesario instalar WSL2 y Docker Desktop.

## Instalar WSL2 en windows 11

Ahora puedes instalar todo lo que necesitas para ejecutar WSL con un solo comando. Abre PowerShell o el Símbolo del sistema de Windows en modo de administrador haciendo clic derecho y seleccionando "Ejecutar como administrador", ingresa el comando wsl --install y luego reinicia tu máquina.

    wsl --install

## Instalando Docker Desktop para Windows

Docker Desktop for Windows es la Edición Comunitaria (CE) de Docker para Microsoft Windows. Para descargar Docker Desktop for Windows, dirígete a Docker Hub.

Enlace: https://hub.docker.com/editions/community/docker-ce-desktop-windows

La instalación proporciona Docker Engine, el cliente Docker CLI, Docker Compose, Docker Machine y Kitematic. Los contenedores e imágenes creados con Docker Desktop for Windows se comparten entre todas las cuentas de usuario en las máquinas donde está instalado. Esto se debe a que todas las cuentas de Windows utilizan la misma máquina virtual (VM) para construir y ejecutar contenedores.

# Instalar GIT

Para clonar el repositorio es necesario instalar GIT. Solo tienes que visitar http://git-scm.com/download/win y la descarga empezará automáticamente. 

# Clonar y ejecutar el contenedor de SocialTech-Challenge

Presiona las teclas windos+R a la vez. En la ventana emergente escribe ***cmd*** y elecuta el comando.

En la ventana negra resultande escribe el siguiente comando:

    git clone https://github.com/SocialTech-Challenge/SocialTech-NOVNC.git

Esto descargará el repositorio que contiene todos los comandos para generar el contenedor con todos los paquetes instalados. Una vez finalizado ejecuta:

    cd SocialTech-NOVNC
    docker compose build

Este proceso llevará bastante la primera vez. Al finalizar puedes ejecutar la siguiente instrucción:

    docker compose up

Esto levantará el contenedor y sin cerrar esta ventana ve a un navegador web y accede a la siguiente dirección http://127.0.0.1:6080, la clave que te pedirá es ***mypasswd***

Dentro del contenedor abre el terminal ***Terminator*** y ejecuta el siguiente comando:

    roslaunch SocialTech-Gazebo prueba1.launch

![alt text](img/imagen1.png)

Se abrirá el RVIZ y el simulador Gazebo. Distribuye las ventanas al gusto, por ejemplo como en la siguiente imagen:

![alt text](img/imagen2.png)

En una nueva pestaña del terminator (sin cerrar la anterior) ejecuta el comando:

    rosrun teleop_twist_keyboard teleop_twist_keyboard.py

**Ya puedes mover el AGV utilizando el teclado.**

## Prueba escenario vacio

Para la primera prueba el escenario estará vacio, teniendo que navegar a la lista de coordenadas que se proporcionen  y teniendo que esperar un tiempo entre punto y punto.

Para poder simular el escenario 1 ejecuta el siguiente comando en una pestaña de la terminal:

    roslaunch SocialTech-Gazebo prueba1.launch

## Comenzar a mapear una zona    

En otra terminal lanza el nodo para generar un mapa con el siguiente comando:

    rosrun gmapping slam_gmapping scan:=/scan

Para visualizar el mapa que se esta generando en RVIZ añade un topic nuevo como se ve en la imagen de abajo.

![alt text](img/imagen4.png)

Ahora usando el nodo de teleoperación podrás ir viendo como se genera un mapa, como en la imagen inferior.

![alt text](img/imagen5.png)

Cuando tengas toda la superficie mapeada en otro terminal ejecuta el comando:

    rosrun map_server map_saver -f mapa

En este momento se generarán dos ficheros, uno con extensión PGM y otro con extensión YAML.

## Prueba escenario con obstaculos

Para añadir un obstaculo al circuito utiliza el siguiente comando:

    roslaunch SocialTech-Gazebo prueba2.launch 

Tras ejecutarlo se abrirá Gazebo con un objeto en las coordenadas x=3, y=5 y girado 45º, como se puede ver en la imagen.

![alt text](img/imagen3.png)

Las coordenadas de origen estan en la esquina inferior izquierda del escenario y cada cuadricula es de 1m. La base del obstaculo es un cuadrado de 0.4m de lado y tiene una altura de 1.2m.