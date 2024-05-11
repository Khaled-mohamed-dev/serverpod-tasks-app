import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tasks_client/tasks_client.dart';
import 'package:tasks_flutter/app/app.locator.dart';
import 'package:tasks_flutter/services/flash_message_service.dart';
import 'package:tasks_flutter/services/tasks_repository_service.dart';
import 'package:tasks_flutter/ui/views/create_task/create_task_view.dart';
import 'package:tasks_flutter/ui/views/create_task/create_task_view.form.dart';
import 'package:tasks_flutter/ui/views/home/home_viewmodel.dart';

class CreateTaskViewModel extends FormViewModel with $CreateTaskView {
  final _tasksRepository = locator<TasksRepositoryService>();
  final _navigationService = locator<NavigationService>();
  final _flashMessage = locator<FlashMessageService>();

  final _homeModel = locator<HomeViewModel>();
  DateTime get date => _homeModel.date;

  String? _priority;

  String? get priority => _priority;

  set priority(String? selected) {
    _priority = selected;
    rebuildUi();
  }

  back() {
    _navigationService.back();
  }

  createTask() async {
    if (_priority == null && taskController.text.isEmpty) {
      _flashMessage.showMessage(
        title: 'Check Inputs',
        message: 'Make sure to write a task name and select priority level',
        type: FlashMessageType.warning,
      );
    } else if (_priority == null && taskController.text.isNotEmpty) {
      _flashMessage.showMessage(
        title: 'Check Inputs',
        message: 'Make sure to  select priority level',
        type: FlashMessageType.warning,
      );
    } else if (_priority != null && taskController.text.isEmpty) {
      _flashMessage.showMessage(
        title: 'Check Inputs',
        message: 'Make sure to write a task name',
        type: FlashMessageType.warning,
      );
    } else {
      var response = await _tasksRepository.createTask(
        Task(
          text: taskController.text,
          priority: priority!,
          date: date.format(),
          isChecked: false,
        ),
      );
      response.fold(
        (l) {
          _flashMessage.showMessage(
            title: 'Error',
            message: l.body,
            type: FlashMessageType.danger,
          );
        },
        (r) {
          locator<HomeViewModel>().addTask(r);
          _navigationService.popUntil((route) => route.isFirst);
          _flashMessage.showMessage(
            title: 'Success',
            message: 'Task is saved to DB successfully',
            type: FlashMessageType.success,
          );
        },
      );
    }
  }
}
