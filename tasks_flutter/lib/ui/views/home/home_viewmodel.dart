import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tasks_client/tasks_client.dart';
import 'package:tasks_flutter/app/app.locator.dart';
import 'package:tasks_flutter/services/tasks_repository_service.dart';
import 'package:tasks_flutter/ui/views/create_task/create_task_view.dart';

class HomeViewModel extends BaseViewModel {
  final _tasksRepository = locator<TasksRepositoryService>();
  final _navigationService = locator<NavigationService>();

  String _filter = 'All';
  String get filter => _filter;

  DateTime _date = DateTime.now();

  DateTime get date => _date;

  final List<Task> _tasks = [];

  List<Task> get tasks {
    if (_filter == 'Completed') {
      return _tasks.where((element) => element.isChecked).toList();
    } else if (_filter == 'Not completed') {
      return _tasks.where((element) => !element.isChecked).toList();
    }
    return _tasks;
  }

  changeFilter(String filter) {
    _filter = filter;
    rebuildUi();
  }

  changeDate(DateTime date) {
    if (_date != date) {
      _date = date;
      fetchTasks();
    }
  }

  void goToCreateTask() async {
    await _navigationService.navigateToView(
      const CreateTaskView(),
      opaque: false,
      popGesture: true,
    );
  }

  fetchTasks() async {
    setBusy(true);
    var response = await _tasksRepository.fetchTasks(_date.format());
    response.fold(
      (l) => setError(l),
      (r) {
        _tasks.clear();
        _tasks.addAll(r);
      },
    );
    setBusy(false);
  }

  editTask(Task task) async {
    var response = await _tasksRepository.editTask(task);
    response.fold(
      (l) {
        setError(l);
      },
      (r) {
        var taskIndex = _tasks.indexWhere((element) => element.id == task.id);
        _tasks[taskIndex] = task;
        rebuildUi();
        print('nice');
      },
    );
  }

  addTask(Task task) async {
    _tasks.add(task);
    rebuildUi();
  }

  deleteTask(Task task) async {
    var response = await _tasksRepository.deleteTask(task);
    response.fold(
      (l) => setError(l),
      (r) {
        _tasks.remove(task);
        rebuildUi();

        print('nice');
      },
    );
  }
}

extension FormatDate on DateTime {
  String formatDate() {
    return '$year-$month-$day';
  }
}

extension DateTimeParse on String {
  DateTime dateTimeParse() {
    List<String> date = split('-');
    var year = date[0];
    var month = int.parse(date[1]) < 10 ? '0${date[1]}' : date[1];
    var day = int.parse(date[2]) < 10 ? '0${date[1]}' : date[1];
    return DateTime.parse('$year-$month-$day');
  }
}
