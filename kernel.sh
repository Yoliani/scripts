gpg --verify linux-5.13.12.tar.sign

sleep 2

echo "Grabi, escriba la clave publica que se le dio gpg --recv-keys (la clave): "

read key
echo "La clave es: $key"
sleep 1

echo "Descomprimiendo el archivo del kernel por favor espere"
tar xvf linux-5.13.12.tar

sleep 1

echo "Entrando a la carpeta donde se descomprimio el kernel"

cd linux-5.13.12
cp -v /boot/config-$(uname -r) .config
