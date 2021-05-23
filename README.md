# syslog-log-viewer


Pimp my Log is a web app written in PHP. It displays server logs friendly.

Formerly named PHP Apache Log Viewer, it has been renamed because any kind of logs can be displayed now.
Basically, you will surely display your Apache, NGINX, IIS or PHP logs, but Ruby on Rails, Tomcat, sshd, syslog, CakePHP, ... too !

It's embedded with rsyslog server to make one container for log monitoring 

## Installation


```bash
git clone https://github.com/greenweb-cloud/syslog-log-viewer/
 
cd syslog-log-viewer
 
docker build -t logserver .
```

## Usage

```bash
docker run -it -e SYSLOG_USERNAME=admin -e SYSLOG_PASSWORD=1234 -p 8080:80 -p 514:514/udp logserver

```
