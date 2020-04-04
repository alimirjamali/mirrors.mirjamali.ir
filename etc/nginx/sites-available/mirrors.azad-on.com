# Virtual Host configuration for Tor Onion Mirror hidden service
#
server {
	listen 80;
	server_name "mirrors.azad-on.com" "mirrors.azad-on.ir" "mirrors.azadon.ir";

	root /var/www/mirrors.azad-on.com;
	index index.html;

	location / { 
		try_files $uri $uri/index.html @upstream;
	}

	location @upstream { 
		proxy_pass http://mirrors.mirjamali.ir;
	}
}

server {
	listen [::]:443 ssl; # managed by Certbot
	listen 443 ssl; # managed by Certbot
	server_name "mirrors.azad-on.com" "mirrors.azad-on.ir" "mirrors.azadon.ir";

	location / {
		proxy_pass http://mirrors.azad-on.com;
	}

	ssl_certificate /etc/letsencrypt/live/azad-on/fullchain.pem; # managed by Certbot
	ssl_certificate_key /etc/letsencrypt/live/azad-on/privkey.pem; # managed by Certbot

	include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

