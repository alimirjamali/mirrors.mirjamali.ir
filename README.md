# [mirrors.mirjamali.ir](https://mirrors.mirjamali.ir) config files
This repository contains bash scripts, systemd units, rsync daemon configuration and other files related to my personal mirror.
### Bash syncrepo files
These files are ordinary bash scripts which should be copied to **/usr/local/bin**
### Systemd Timers and Services
Instead of using cron to run sync scripts periodically, I am using systemd timers.
Copy them to **/etc/systemd/system**; Enable/Start timer or service with systemctl.
### HTML and CSS
Obviously these files are for the webserver (/var/www).
## Credits
The original bash scripts and systemd units are based on [Archlinux's scripts](https://git.archlinux.org/infrastructure.git/tree/roles/syncrepo/).<br/>
[Vazir fonts](https://github.com/rastikerdar/vazir-font) provided by Saber Rastikerdar.
