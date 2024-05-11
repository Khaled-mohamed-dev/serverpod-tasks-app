import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:tasks_client/tasks_client.dart';
import 'package:tasks_flutter/main.dart';

class BaseClientService {
  var client = Client(baseUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor();
}

class AppException implements Exception {
  final String body;

  AppException(this.body);
}
