#!/bin/bash
#Pure-FTP
yum install epel-release -y
yum upgrade ca-certificates --disablerepo=epel -y
yum install pure-ftpd -y

#Alterar porta ssh
echo 'Mudar Porta do SSH'
clear;
echo ""
echo ""
echo -e '\E[37;32m''\033[1m*********************************************************************************************\033[0m'
echo -e '\E[37;32m''\033[1m*         Descomente a linha que especifica a porta do SSH e muda para porta 2222                    \033[0m'
echo -e '\E[37;32m''\033[1m*     E salve usando os comandos : (CTRL + X \\ Enter \\Y)                        \033[0m'
echo -e '\E[37;32m''\033[1m*                                                               \033[0m'
echo -e '\E[37;32m''\033[1m*                                                                 \033[0m'
echo -e '\E[37;32m''\033[1m*********************************************************************************************\033[0m'
echo ""
echo ""
nano /etc/ssh/sshd_config
service sshd restart

#instalando dependencias
yum install nano iptables vixie-cron nmap perl-libs -y;
iptables -F
service iptables save
chkconfig iptables on
chkconfig crond on
chkconfig pure-ftpd on

yum upgrade -y

ln -s /usr/bin/nano /usr/bin/pico
adduser streaming
find /home/streaming -type d -exec chmod 777 {} \;
cd /home/
wget http://picstream.ml/painel_voxstream/streaming_cliente.tar.gz
tar -zxvf streaming_cliente.tar.gz
wget http://picstream.ml/painel_voxstream/updatenew.sh; chmod 777 updatenew.sh;./updatenew.sh

find /home/streaming/ -type d -exec chmod 777 {} \;
cd /home/streaming
rm -rfv /etc/bashrc
mv -v bashrc /etc/bashrc
source /etc/bashrc
echo >> /root/.bash_profile
echo 'cd /home/streaming' >> /root/.bash_profile
mv monitor.txt /bin/monitor
chmod 777 /bin/monitor

rm -rf -v /var/spool/cron/root
mv -v cron.streaming.txt /var/spool/cron/root
service crond restart

//ajustar hora do servidor
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/posix/Brazil/East /etc/localtime
rdate -s rdate.cpanel.net
yum -y install ntp
ntpdate 0.br.pool.ntp.org

tar -zxvf les-current.tar.gz
cd les-*
sh install.sh
/usr/local/sbin/les -ea

cd /home/streaming
rm -rf les-0.2/ *.rpm *.tar.gz *.txt *.zip
passwd streaming
mv -v pure-ftpd.conf pureftpd-mysql.conf /etc/pure-ftpd/
service pure-ftpd restart
find /home/streaming/ -type d -exec chmod 777 {} \;

echo 'Instalação concluida!'
clear;
echo ""
echo ""
echo -e '\E[37;32m''\033[1m*********************************************************************************************\033[0m'
echo -e '\E[37;32m''\033[1m*          Agora edite o arquivo #nano /etc/pure-ftpd/pureftpd-mysql.conf                      \033[0m'
echo -e '\E[37;32m''\033[1m*     e informe o banco de dados, lembre-se de reiniciar o pure-ftpd                         \033[0m'
echo -e '\E[37;32m''\033[1m*                                        #service pure-ftpd restart;                         \033[0m'
echo -e '\E[37;32m''\033[1m*                                                                     \033[0m'
echo -e '\E[37;32m''\033[1m*********************************************************************************************\033[0m'
echo ""
echo ""
# Only root can run this


