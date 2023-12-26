# postinstall
Das Linux-Postinstall Repo


## Linux-LXC-Container

```bash
mkdir /apps && cd /apps
git clone https://github.com/Mesrine88/postinstall.git
cd postinstall
apt install dos2unix -y
dos2unix *
chmod +x lxc-postinstall.sh
bash vm-postinstall.sh
```
___

## Linux-VMs

```bash
mkdir /apps && cd /apps
git clone https://github.com/Mesrine88/postinstall.git
cd postinstall
apt install dos2unix -y
dos2unix *
chmod +x vm-postinstall.sh
bash vm-postinstall.sh
```
____

## PVE

```bash
mkdir /apps && cd /apps
git clone https://github.com/Mesrine88/postinstall.git
cd postinstall
apt install dos2unix -y
dos2unix *
chmod +x postinstallPVE.sh
bash postinstallPVE.sh
```

