# Hello World Application

## Prerequisites
- Docker installed on your system.
- MySQL database set up using `init.sql`.

## Steps to Build and Run

1. Clone the repository:
   ```bash
   git clone <repository_url>
   cd <repository_name>

docker build -t hello-world-app .

docker run -p 8080:8080 --env MYSQL_SERVER=<server> \
                         --env MYSQL_USER=<user> \
                         --env MYSQL_PASSWORD=<password> \
                         --env MYSQL_DB=hello_world hello-world-app

