import 'package:get/get.dart';
import 'package:getxtodo/db/db_helper.dart';
import 'package:getxtodo/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;
  getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void markUsCompleted(int taskID) async {
    await DBHelper.update(taskID);
    getTasks();
  }

  static addTask({required Task task}) {
    return DBHelper.insert(task);
  }
}
