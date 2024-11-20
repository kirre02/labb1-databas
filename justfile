_default:
    just --list

start:
    docker start mysql

create:
  docker run --name mysql -e MYSQL_ROOT_PASSWORD=securepassword -e 'MYSQL_ROOT_HOST=%' -p 3306:3306 -d mysql:9.1.0

down container_id:
  docker stop {{ container_id }}
