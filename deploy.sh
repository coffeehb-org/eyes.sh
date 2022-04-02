docker pull mysql
docker run -d -p 33006:3306 -e MYSQL_ROOT_PASSWORD=eyesdnslog2022 --name=mysql mysql
apt install python3.8

curl https://pyenv.run | bash
echo -e '''export PATH="/root/.pyenv/bin:$PATH"\neval "$(pyenv init -)"\neval "$(pyenv virtualenv-init -)"''' >>/root/.bashrc
source /root/.bashrc
pyenv install 3.8.2
pyenv virtualenv 3.8.2 dnslog
~/.pyenv/versions/dnslog/bin/pip3  




~/.pyenv/versions/dnslog/bin/python manage.py makemigrations logview
~/.pyenv/versions/dnslog/bin/python manage.py migrate
~/.pyenv/versions/dnslog/bin/python manage.py collectstatic
~/.pyenv/versions/dnslog/bin/gunicorn --workers 5 --bind 127.0.0.1:8000 dnslog.wsgi:application --daemon
nohup ~/.pyenv/versions/3.8.2/envs/dnslog/bin/python3.8 ./zoneresolver.py &
cp dnslog_nginx.conf /etc/nginx/conf.d/
setsebool httpd_can_network_connect on
setenforce permissive
systemctl restart nginx
timedatectl set-timezone Asia/Shanghai
