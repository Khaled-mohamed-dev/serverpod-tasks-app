import 'package:dartz/dartz.dart' hide Task;
import 'package:tasks_client/tasks_client.dart';
import 'package:tasks_flutter/app/app.locator.dart';
import 'package:tasks_flutter/services/base_client_service.dart';

class TasksRepositoryService {
  final Client client = locator<BaseClientService>().client;

  Future<Either<AppException, List<Task>>> fetchTasks(DateTime date) async {
    try {
      List<Task> tasks = await client.tasks.getAllTasks(date);
      return Right(tasks);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  Future<Either<AppException, Unit>> editTask(Task task) async {
    try {
      await client.tasks.editTask(task);
      return const Right(unit);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  Future<Either<AppException, Task>> createTask(Task task) async {
    try {
      Task insertedTask = await client.tasks.createTask(task);
      return Right(insertedTask);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  Future<Either<AppException, Unit>> deleteTask(Task task) async {
    try {
      await client.tasks.deleteTask(task);
      return const Right(unit);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}
