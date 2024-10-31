# Specify the Dart SDK base image version using dart:<version> (ex: dart:2.12)
FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code and AOT compile it.
COPY . .
# Ensure packages are still up-to-date if anything has changed
RUN dart pub get --offline
# RUN dart compile exe bin/main.dart -o bin/main

ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
# FROM scratch
# COPY --from=build /runtime/ /
# COPY --from=build /app/bin/server /app/bin/

# Start server.
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Command to run the application
CMD dart bin/tasks_server.dart --apply-migrations && bin/main --mode $runmode --server-id $serverid --logging $logging --role $role
