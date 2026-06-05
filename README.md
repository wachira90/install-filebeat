# INSTALL-FILEBEAT

## INSTALL UBUNTU 24.04

```sh
git clone https://github.com/wachira90/install-filebeat.git

cd install-filebeat/

sudo chmod +x install-ubuntu2404.sh

sudo ./install-ubuntu2404.sh
```

## CHECK PROCESS RUNNING

```sh
sudo systemctl status filebeat

```

## TEST CONFIG AND TEST ERROR

```sh
sudo filebeat test config -c /etc/filebeat/filebeat.yml

sudo journalctl -u filebeat.service -xe --no-pager | tail -n 50

```