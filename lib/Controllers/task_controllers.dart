import 'package:get/get.dart';
import 'package:to_do_app/Helpers/taskhelpers.dart';

import '../Models/taskmodel.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(
      tasks.map((data) => Task.fromJson(data)).toList(),
    );
  }

  void delete(Task task) {
    DBHelper.Delete(task);
    getTasks();
  }

  void markTaskComplete(int id) async {
   await DBHelper.update(id);
   getTasks();
  }
}
