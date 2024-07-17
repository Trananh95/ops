# Practice with Nginx

## Install Nginx

Ubuntu/Debian

```
sudo apt update
sudo apt install nginx

```

## Adjusting the Firewall
* List the application configurations that ufw knows how to work with by typing:
`sudo ufw app list`

* To allow traffic on port 80 and 443:
`sudo ufw allow 'Nginx Full'`

* You can verify the change by typing:

`sudo ufw status`

## Managing the Nginx Process

* To stop your web server, type:
`sudo systemctl stop nginx`

* To start the web server when it is stopped, type:
`sudo systemctl start nginx`

* To stop and then start the service again, type:
`sudo systemctl restart nginx`

* If you are only making configuration changes, Nginx can often reload without dropping connections. To do this, type:

`sudo systemctl reload nginx`

* By default, Nginx is configured to start automatically when the server boots. If this is not what you want, you can disable this behavior by typing:
`sudo systemctl disable nginx`

* To re-enable the service to start up at boot, you can type:

`sudo systemctl enable nginx`


## Setting Up Server Blocks

* When using the Nginx web server, server blocks (similar to virtual hosts in Apache) can be used to encapsulate configuration details and host more than one domain from a single server. We will set up a domain called your_domain, but you should replace this with your own domain name.
`sudo mkdir -p /var/www/your_domain/html`

Next, assign ownership of the directory with the $USER environment variable:
`sudo chown -R $USER:$USER /var/www/your_domain/html`

* The permissions of your web roots should be correct if you haven’t modified your umask value, which sets default file permissions. To ensure that your permissions are correct and allow the owner to read, write, and execute the files while granting only read and execute permissions to groups and others, you can input the following command:

`sudo chmod -R 755 /var/www/your_domain`

* Next, create a sample index.html page using nano or your favorite editor:

`sudo nano /var/www/your_domain/html/index.html`

* Next, create a sample index.html page using nano or your favorite editor:
`sudo nano /var/www/your_domain/html/index.html`

* Inside, add the following sample HTML:

```
<html>
    <head>
        <title>Welcome to your_domain!</title>
    </head>
    <body>
        <h1>Success!  The your_domain server block is working!</h1>
    </body>
</html>
```

* In order for Nginx to serve this content, it’s necessary to create a server block with the correct directives. Instead of modifying the default configuration file directly, let’s make a new one at /etc/nginx/sites-available/your_domain:
    `sudo nano /etc/nginx/sites-available/your_domain`

* aste in the following configuration block, which is similar to the default, but updated for our new directory and domain name:
```
    server {
        listen 80;
        listen [::]:80;

        root /var/www/your_domain/html;
        index index.html index.htm index.nginx-debian.html;

        server_name your_domain www.your_domain;

        location / {
                try_files $uri $uri/ =404;
        }
    }

``` 
 * Next, let’s enable the file by creating a link from it to the sites-enabled directory, which Nginx reads from during startup:
 `sudo ln -s /etc/nginx/sites-available/your_domain /etc/nginx/sites-enabled/`

 * Next, test to make sure that there are no syntax errors in any of your Nginx files:
 `sudo nginx -t`

 * If there aren’t any problems, restart Nginx to enable your changes:

`sudo systemctl restart nginx`

## Server Configuration
* /etc/nginx: The Nginx configuration directory. All of the Nginx configuration files reside here.
* /etc/nginx/nginx.conf: The main Nginx configuration file. This can be modified to make changes to the Nginx global configuration.
* /etc/nginx/sites-available/: The directory where per-site server blocks can be stored. Nginx will not use the configuration files found in this directory unless they are linked to the sites-enabled directory. Typically, all server block configuration is done in this directory, and then enabled by linking to the other directory.
* /etc/nginx/sites-enabled/: The directory where enabled per-site server blocks are stored. Typically, these are created by linking to configuration files found in the sites-available directory.
* /etc/nginx/snippets: This directory contains configuration fragments that can be included elsewhere in the Nginx configuration. Potentially repeatable configuration segments are good candidates for refactoring into snippets.