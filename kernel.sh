# _        _______  _______  _        _______  _       
#| \    /\(  ____ \(  ____ )( (    /|(  ____ \( \      
#|  \  / /| (    \/| (    )||  \  ( || (    \/| (      
#|  (_/ / | (__    | (____)||   \ | || (__    | |      
#|   _ (  |  __)   |     __)| (\ \) ||  __)   | |      
#|  ( \ \ | (      | (\ (   | | \   || (      | |      
#|  /  \ \| (____/\| ) \ \__| )  \  || (____/\| (____/\
#|_/    \/(_______/|/   \__/|/    )_)(_______/(_______/
                                                      
# _______  _______  _______  _______ _________ _        _______ 
#(  ____ \(  ___  )(       )(  ____ )\__   __/( \      (  ____ \
#| (    \/| (   ) || () () || (    )|   ) (   | (      | (    \/
#| |      | |   | || || || || (____)|   | |   | |      | (__    
#| |      | |   | || |(_)| ||  _____)   | |   | |      |  __)   
#| |      | |   | || |   | || (         | |   | |      | (      
#| (____/\| (___) || )   ( || )      ___) (___| (____/\| (____/\
#(_______/(_______)|/     \||/       \_______/(_______/(_______/




echo "Dependencias"
sudoapt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev bc neofetch
sudo apt-get update
sudo apt-get install initramfs-tools
sudo apt-get update
sleep 2

echo "Descargando version estable del kernel"

wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.13.12.tar.xz
unxz -v linux-5.6.9.tar.xz

echo "Revisando las llaves"

gpg --verify linux-5.13.12.tar.sign

sleep 2

echo "Grab, escriba la clave publica que se le dio gpg --recv-keys (la clave): "

read key
echo "La clave es: $key"
sleep 1

echo "Descomprimiendo el archivo del kernel por favor espere"
tar xvf linux-5.13.12.tar

sleep 1

echo "Entrando a la carpeta donde se descomprimio el kernel"

cd linux-5.13.12
cp -v /boot/config-$(uname -r) .config

make menuconfig

#Se obtiene la cantidad de hilos con nproc
sleep 5
echo "Se empezara a compilar el kernel"
sleep 2
make -j $(nproc)


echo "Instalando los modulos del kernel"
sleep 2


sudo make modules_install

sleep 1
echo "Terminando la instalación"
sleep 1

sudo make install

echo "Actualizando el grub"
sudo update-initramfs -c -k 5.13.12
sudo update-grub

echo "Se reiniciara en 3 segundos"
sleep 3

sudo systemctl reboot
