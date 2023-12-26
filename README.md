# postinstall
Das Linux-Postinstall Repo

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



## PVE
