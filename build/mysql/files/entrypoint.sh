#!/bin/sh

if [ ! -d /var/lib/mysql/mysql/ ]; then
    
    echo "[ mysql ] No database(s) found!"
    echo ""
    echo "--------------------------"
    echo "[ mysql ] Setup > Starting.."
    echo "--------------------------"
    echo ""

    /usr/bin/mysql_install_db --defaults-file=/etc/my.cnf > /dev/null

    if [[ -z $MYSQL_ROOT_PASSWORD ]]; then
        MYSQL_ROOT_PASSWORD=$(< /dev/urandom tr -dc a-zA-Z0-9 | head -c${1:-30};echo;)

        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        echo "[ mysql ] > Setup > No MYSQL_ROOT_PASSWORD specified, generating one.."
        echo "[ mysql ] > Setup > MYSQL_ROOT_PASSWORD set to $MYSQL_ROOT_PASSWORD"
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    fi

    cat << EOF > /tmp/sql
    FLUSH PRIVILEGES;
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD";
    DELETE FROM mysql.user WHERE Host = 'localhost';

    CREATE DATABASE $MYSQL_OBSERVIUM_DATABASE DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
    GRANT ALL PRIVILEGES ON $MYSQL_OBSERVIUM_DATABASE.* TO "$MYSQL_OBSERVIUM_USERNAME"@'%' IDENTIFIED BY "$MYSQL_OBSERVIUM_PASSWORD";
EOF

    /usr/bin/mysqld -u root --bootstrap < /tmp/sql

    echo ""
    echo "--------------------------"
    echo "[ mysql ] Setup > Complete.."
    echo "--------------------------"
    echo ""
fi

echo "[ mysql ] Starting MySQL Service.."
/usr/bin/mysqld_safe