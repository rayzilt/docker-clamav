# rayzilt/clamav #

Non-Official Dockerized [Clamav](http://www.clamav.net/) based on Debian Stretch Slim.

### Tags ###
Branch  | Version  | Tag Name     | Dockerfile
------- | -------- | ------------ | ---------
Stable | [![](https://images.microbadger.com/badges/version/rayzilt/clamav.svg)](https://microbadger.com/images/rayzilt/clamav "Get your own version badge on microbadger.com")  | latest       | [Dockerfile](https://github.com/Rayzilt/Docker-Clamav/blob/master/Dockerfile)

### Environment Variables ###
No environment variables are used.

### Volumes ###
No volumes are defined.

### Exposed Ports ###
Port | Function
---- | ------------
3310 | Clamd

### Healthcheck ###
The healthcheck runs every minute to check if Clamd and Freshclam are still running.
Script `healthcheck.sh` will be responsible for this. It checks if both processes are present using `pgrep`.

### Usage ###
Every startup the container will run freshclam to download the latest definitions available.
After a successfull download, freshclam and clamd are started as daemon.
Both programs print there output to console.

Every hour freshclam checks for new definitions.
 
### References ###
* Clamav Official website: https://clamav.net/
* Documentation: http://www.clamav.net/documents/
* Clamav Github: https://github.com/Cisco-Talos/clamav-devel

### Support ###
This Docker image is for personal use but let me know if there are any improvements available.
Please use [Github](https://github.com/Rayzilt/Docker-Clamav) to send me a message.
