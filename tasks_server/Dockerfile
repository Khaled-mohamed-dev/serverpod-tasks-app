FROM dart:stable AS build

WORKDIR /app
COPY . .

RUN dart pub get

ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

CMD dart bin/tasks_server.dart --apply-migrations --mode $runmode --server-id $serverid --logging $logging --role $role
