import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:tasks_flutter/ui/views/home/home_view.dart';
import 'package:tasks_flutter/services/base_client_service.dart';
import 'package:tasks_flutter/services/tasks_repository_service.dart';
import 'package:tasks_flutter/ui/views/create_task/create_task_view.dart';
import 'package:tasks_flutter/ui/views/home/home_viewmodel.dart';
import 'package:tasks_flutter/services/flash_message_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: CreateTaskView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),

    LazySingleton(classType: BaseClientService),
    LazySingleton(classType: TasksRepositoryService),
    LazySingleton(classType: HomeViewModel),

    LazySingleton(classType: FlashMessageService),
// @stacked-service
  ],
  logger: StackedLogger(),
)
class App {}
