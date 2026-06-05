#!/bin/bash
set -e
echo "=========================================="
echo " Starting Filebeat Installation..."
echo "=========================================="
echo "[1/6] Installing dependencies (wget, apt-transport-https, gnupg2)..."
sudo apt-get update -y
sudo apt-get install -y wget apt-transport-https gnupg2
echo "[2/6] Adding Elastic GPG key..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
echo "[3/6] Adding Elastic 8.x repository..."
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list > /dev/null
echo "[4/6] Updating package lists and installing Filebeat..."
sudo apt-get update -y
sudo apt-get install -y filebeat
sudo apt install auditd audispd-plugins -y
echo "[5/6] Add Config Filebeat service..."
sudo filebeat modules enable logstash
sudo filebeat modules enable auditd
sleep 2
sudo cp auditd.conf /etc/audit/auditd.conf
sudo cp logstash.yml /etc/filebeat/modules.d/logstash.yml
sudo cp auditd.yml /etc/filebeat/modules.d/auditd.yml
sudo cp filebeat.yml /etc/filebeat/filebeat.yml
sudo cp custom.rules /etc/audit/rules.d/custom.rules
sleep 2
sudo augenrules --load
echo "[6/6] Enabling and starting Filebeat service..."
sudo systemctl enable auditd
sudo systemctl start auditd
sudo systemctl enable filebeat
sudo systemctl start filebeat
echo "=========================================="
echo " Filebeat installation completed successfully!"
echo "=========================================="
echo ""
echo "To check the service status, run: sudo systemctl status filebeat"
echo "The main configuration file is located at: /etc/filebeat/filebeat.yml"
