import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import 'package:tasks_flutter/app/app.locator.dart';
import 'package:tasks_flutter/app/app.router.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.

// use This if you are testing on an emulator
// const String baseUrl = 'http://localhost:8080/';

// use this if you are testing on physical device and change "ip-address" with your own device ip
const String baseUrl = 'http://"ip-address":8080/';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.all.first,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
      theme: ThemeData.light(useMaterial3: false),
    );
  }
}
