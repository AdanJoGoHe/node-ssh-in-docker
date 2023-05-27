# Selecciona una imagen de Node.js de Docker Hub
FROM node:14

# Instala OpenSSH
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Configura un usuario y una contraseña para SSH
RUN useradd -m developer && echo 'developer:password' | chpasswd

# Expone el puerto SSH
EXPOSE 22

# Comando para iniciar el servidor SSH
CMD ["/usr/sbin/sshd", "-D"]
