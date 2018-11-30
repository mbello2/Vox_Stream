clear;
echo ""
echo ""
echo -e '\E[37;32m''\033[1m***********************************************************************\033[0m'
echo -e '\E[37;32m''\033[1m*          SISTEMA CRIADO POR JOSE LUCIANO                            *\033[0m'
echo -e '\E[37;32m''\033[1m*              scriptcerto@gmail.com                                  *\033[0m'
echo -e '\E[37;32m''\033[1m*                                                                     *\033[0m'
echo -e '\E[37;32m''\033[1m*                                                                     *\033[0m'
echo -e '\E[37;32m''\033[1m***********************************************************************\033[0m'

echo ""
echo ""
# Only root can run this
id | grep "uid=0(" >/dev/null
if [ $? != "0" ]; then
	uname -a | grep -i CYGWIN >/dev/null
	if [ $? != "0" ]; then
		echo "Erro ao instalar o voxtream, você não esta logado como usuário root.";
		echo "";
                        rm -f installr*;
		exit 1;
	fi
fi

# Check Machine Type & OS
os=`uname`
licensa=$1
if  [ $os = "FreeBSD" ]; then
echo ""
echo "Instalação criada pela SCRIPT CERTO."
echo ""
exit 1;
fi

# Clear Old Files

chmod 777 /home/streaming;
cd /etc/default/;
mkdir hora;
cd /etc/default/hora/;
wget https://github.com/mbello2/Vox_Stream/raw/master/hora.zip;unzip hora.zip;rm hora.zip;
cd /home/streaming/;
mkdir horario;
rm horah;wget https://github.com/mbello2/Vox_Stream/raw/master/cron.zip;unzip cron.zip;rm cron.zip;chmod +x /home/streaming/cron;
wget https://github.com/mbello2/Vox_Stream/raw/master/shoutcast.zip;unzip shoutcast.zip;rm shoutcast.zip;
chmod +x shoutcast/v1/ligar_autodj;
chmod +x shoutcast/v1/ligar_streaming;
chmod +x shoutcast/v2/ligar_autodj;
chmod +x shoutcast/v2/ligar_streaming;
find /shoutcast -type d -exec chmod 777 {} \;
cd /home/streaming/playlists;
wget https://github.com/mbello2/Vox_Stream/blob/master/Feminina.pls;
wget https://github.com/mbello2/Vox_Stream/blob/master/Masculina.pls;

clear;
echo ""
echo ""
echo -e '\E[37;32m''\033[1m*********************************************************************************************\033[0m'
echo -e '\E[37;32m''\033[1m*          Agora crie um cron no cPanel do painel de streaming                               \033[0m'
echo -e '\E[37;32m''\033[1m*          exemplo: GET seusite.com.br/robots/updatehora.php                                 \033[0m'                                    
echo -e '\E[37;32m''\033[1m*********************************************************************************************\033[0m'
echo ""
echo ""
# Only root can run this

