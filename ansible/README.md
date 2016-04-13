# Ansible para Vagrant con Ruby y Middleman

Este repositorio contiene un conjunto de roles para instalar la máquina
virtual de desarrollo con Vagrant. Se va a instalar Ruby con rbenv,
tmux y vim con Janus.

Pasos para ejecutar esta regla:

1. Instalar Ansible en el host anfitrion. Para ello voy a utilizar una
   regla externa. Instalar desde ``ansible-galaxy install
dwcramer.ansible``
2. Para instalar ruby voy a utilizar rbenv. Hay que descargar la regla
   para rbenv ``sudo ansible-galaxy install zzet.rbenv``

