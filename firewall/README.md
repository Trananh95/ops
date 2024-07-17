# Practice with FireWall

## Install FireWall

**Ubuntu/Debian**:
```
sudo apt update
sudo apt upgrade
```

* Install firewall:
`sudo apt-get install ufw`

* Enable firewall
`sudo ufw enable`

* Reset firewall
`sudo ufw reset`

* Config firewall
-   Step1: Make sure IPv6 is Enabled
`sudo nano /etc/default/ufw`
    Set the value of IPV6 is *yes*
    `IPV6=yes`
-   Step2: Setting up default policies
By default, UFW is set to deny all incoming connections and allow all outgoing connections. This means anyone trying to reach your server would not be able to connect, while any application within the server would be able to reach the outside world. Additional rules to allow specific services and ports are included as exceptions to this general policy.
To set the default UFW incoming policy to *deny*, run:
`sudo ufw default deny incoming`

To set the default UFW outgoing policy to *allow*, run:
`sudo ufw default allow outgoing`

-   Step3: Allow SSH Connections
Upon installation, most applications that rely on network connections will register an application profile within UFW, which enables users to quickly allow or deny external access to a service. You can check which profiles are currently registered in UFW with:
`sudo ufw app list`

To enable the OpenSSH application profile, run:
`sudo ufw allow OpenSSH`

Allowing SSH by Port Number
`sudo ufw allow 22`

-   Step3: Allow other connections
    HTTP on port 80, which is what unencrypted web servers use, using `sudo ufw allow http or sudo ufw allow 80`
    HTTPS on port 443, which is what encrypted web servers use, using `sudo ufw allow https or sudo ufw allow 443`
    Apache with both HTTP and HTTPS, using `sudo ufw allow ‘Apache Full’`
    Nginx with both HTTP and HTTPS, using `sudo ufw allow ‘Nginx Full’`

    
    * Allow Specific Port Ranges:

    ```
        sudo ufw allow 6000:6007/tcp
        sudo ufw allow 6000:6007/udp
    ```
    
    * Allow Specific IP Addresses:
    When working with UFW, you can also specify IP addresses within your rules. For example, if you want to allow connections from a specific IP address, such as a work or home IP address of 203.0.113.4, you need to use the from parameter, providing then the IP address you want to allow:
    `sudo ufw allow from 203.0.113.4`
    You can also specify a port that the IP address is allowed to connect to by adding to any port followed by the port number. For example, If you want to allow 203.0.113.4 to connect to port 22 (SSH), use this command:
    `sudo ufw allow from 203.0.113.4 to any port 22`

    * Allow Subnets:
    If you want to allow a subnet of IP addresses, you can do so using CIDR notation to specify a netmask. For example, if you want to allow all of the IP addresses ranging from 203.0.113.1 to 203.0.113.254 you could use this command:
    `sudo ufw allow from 203.0.113.0/24`
    
    * Allow Connections to a Specific Network Interface:
    If you want to create a firewall rule that only applies to a specific network interface, you can do so by specifying “allow in on” followed by the name of the network interface.

    You may want to look up your network interfaces before continuing. To do so, use this command:
    `ip addr`
    The output:
    ```
    2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state

    3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default

    ```
    So, if your server has a public network interface called eth0, you could allow HTTP traffic (port 80) to it with this command:

    `sudo ufw allow in on eth0 to any port 80`

    Or, if you want your MySQL database server (port 3306) to listen for connections on the private network interface eth1, for example, you could use this command:

    `sudo ufw allow in on eth1 to any port 3306`

    This would allow other servers on your private network to connect to your MySQL database.

    -   Step6: Deny Connections

    For example, to deny HTTP connections, you could use this command:
    `sudo ufw deny http`

    Or if you want to deny all connections from 203.0.113.4 you could use this command:

    `sudo ufw deny from 203.0.113.4`

    In some cases, you may also want to block outgoing connections from the server. To deny all users from using a port on the server, such as port 25 for SMTP traffic, you can use deny out followed by the port number:
    `sudo ufw deny out 25`

    -   Step7: Delete Rules:
    * Deleting a UFW Rule By Number
    To delete a UFW rule by its number, first you’ll want to obtain a numbered list of all your firewall rules. The UFW status command has an option to display numbers next to each rule, as demonstrated here:
    `sudo ufw status numbered`

    If you decide that you want to delete rule number 2, the one that allows port 80 (HTTP) connections, you can specify it in a UFW delete command like this:
    `sudo ufw delete 2`

    * Deleting a UFW Rule By Name
    Instead of using rule numbers, you may also refer to a rule by its human readable denomination, which is based on the type of rule (typically allow or deny) and the service name or port number that was the target for this rule, or the application profile name in case that was used. For example, if you want to delete an allow rule for an application profile called Apache Full that was previously enabled, you can use:
    `sudo ufw delete allow "Apache Full"`
    Because service names are interchangeable with port numbers when specifying rules, you could also refer to the same rule as allow 80, instead of allow http:
    `sudo ufw delete allow 80`

    










