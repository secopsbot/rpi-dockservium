# Dockservium
Observium Dockerised, for the Raspberry Pi

## Requirements

* Docker
* Docker-compose
* Pi (Optional, will run elsewhere)

## Usage (quick start)

* Clone repo
* Start containers
  ```bash
  docker-compose up
  ```

## Customisations

The following can be customised including storage of persistent data;

### Persistent Data

Modify `docker-compose.yml` uncommenting volumes to store mysql data, rrd files and observium logs.

### MySQL root password

MySQL root password can be customised from the default autogenerated by adding `MYSQL_ROOT_PASSWORD` to `.env` and add to the `docker-compose.yml` file

### Default Observium admin credentials

Credentials for the default admin account can be customised in `.env`

## Known Issues

#### MySQL Volume on OSX
When persisting data on OSX an error occurs on during the creation of the database.

```bash
> docker-compose up
Creating network "dockservium_default" with the default driver
Creating dockservium_mysql_1 ... done
Creating dockservium_observium_1 ... done
Attaching to dockservium_mysql_1, dockservium_observium_1
mysql_1      | [ mysql ] No database(s) found!
mysql_1      |
mysql_1      | --------------------------
mysql_1      | [ mysql ] Setup > Starting..
mysql_1      | --------------------------
mysql_1      |
mysql_1      | 2020-04-25 20:41:55 0 [ERROR] InnoDB: preallocating 12582912 bytes for file ./ibdata1 failed with error 95
mysql_1      | 2020-04-25 20:41:55 0 [ERROR] InnoDB: Could not set the file size of './ibdata1'. Probably out of disk space
mysql_1      | 2020-04-25 20:41:55 0 [ERROR] InnoDB: Database creation was aborted with error Generic error. You may need to delete the ibdata1 file before trying to start up again.
mysql_1      | 2020-04-25 20:41:56 0 [ERROR] Plugin 'InnoDB' init function returned error.
mysql_1      | 2020-04-25 20:41:56 0 [ERROR] Plugin 'InnoDB' registration as a STORAGE ENGINE failed.
mysql_1      | 2020-04-25 20:41:56 0 [ERROR] Unknown/unsupported storage engine: InnoDB
mysql_1      | 2020-04-25 20:41:56 0 [ERROR] Aborting
```