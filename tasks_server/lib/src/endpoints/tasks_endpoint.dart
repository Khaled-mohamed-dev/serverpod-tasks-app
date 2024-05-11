import 'package:serverpod/server.dart';

import '../generated/protocol.dart';

class TasksEndpoint extends Endpoint {
  // Endpoint implementation goes here
  Future<Task> createTask(Session session, Task task) async {
    Task newTask = await Task.db.insertRow(session, task);
    return newTask;
  }

  Future<void> editTask(Session session, Task task) async {
    await Task.db.updateRow(session, task);
  }

  Future<void> deleteTask(Session session, Task task) async {
    await Task.db.deleteRow(session, task);
  }

  Future<List<Task>> getAllTasks(Session session, DateTime date) async {
    // By ordering by the id column, we always get the notes in the same order
    // and not in the order they were updated.
    return await Task.db.find(
      session,
      where: (p0) => p0.date.equals(date),
      orderBy: (t) => t.id,
    );
  }
}
