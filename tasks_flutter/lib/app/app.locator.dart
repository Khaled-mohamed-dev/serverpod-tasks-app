// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/base_client_service.dart';
import '../services/flash_message_service.dart';
import '../services/tasks_repository_service.dart';
import '../ui/views/home/home_viewmodel.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => BaseClientService());
  locator.registerLazySingleton(() => TasksRepositoryService());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => FlashMessageService());
}
