#!/bin/sh

until /usr/bin/mysql -u ${MYSQL_OBSERVIUM_USERNAME} -h mysql -p${MYSQL_OBSERVIUM_PASSWORD} -e "use ${MYSQL_OBSERVIUM_DATABASE};"; do
    echo "[ Observium Bootstrap ] - Unable to connect to MySQL... retrying in 5 seconds..."
    echo "/usr/bin/mysql -u ${MYSQL_OBSERVIUM_USERNAME} -h mysql -p${MYSQL_OBSERVIUM_PASSWORD} -e \"use ${MYSQL_OBSERVIUM_DATABASE};\""
    sleep 5
done

echo "[ Observium Bootstrap ] - Setup database.."
/usr/bin/php /opt/observium/discovery.php -u

echo "[ Observium Bootstrap ] - Create ${OBSERVIUM_ADMIN_USERNAME} user.."
/usr/bin/php /opt/observium/adduser.php ${OBSERVIUM_ADMIN_USERNAME} ${OBSERVIUM_ADMIN_PASSWORD} 10

echo "[ Observium Bootstrap ] - Add demo device.."
/usr/bin/php /opt/observium/add_device.php demo.snmplabs.com public

echo "[ Observium Bootstrap ] - Complete"