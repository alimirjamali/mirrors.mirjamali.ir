# Virtual Host configuration for mirrors.azad-on.com
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
		# Temporary redirecting all request to upstream server(s) as the main server is going to shutdown :-(
		# proxy_pass http://mirrors.mirjamali.ir;
		return 302 http://mirrors.mirjamali.ir$request_uri;
	}
}

server {
	listen [::]:443 ssl; # managed by Certbot
	listen 443 ssl; # managed by Certbot
	server_name "mirrors.azad-on.com" "mirrors.azad-on.ir" "mirrors.azadon.ir";

	# Here again, temporary redirecting all request to upstream server(s) as the main server is going to shutdown :-(
	# location / {
	#	proxy_pass http://mirrors.azad-on.com;
	#}
	root /var/www/mirrors.azad-on.com;
	index index.html;

	location / { 
		try_files $uri $uri/index.html @upstream_https;
	}
	location @upstream_https { 
		# Temporary redirecting all request to upstream server(s) as the main server is going to shutdown :-(
		# proxy_pass http://mirrors.mirjamali.ir;
		return 302 https://mirrors.mirjamali.ir$request_uri;
	}
	# :-(

	ssl_certificate /etc/letsencrypt/live/azad-on/fullchain.pem; # managed by Certbot
	ssl_certificate_key /etc/letsencrypt/live/azad-on/privkey.pem; # managed by Certbot

	include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

