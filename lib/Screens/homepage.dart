import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/Controllers/task_controllers.dart';
import 'package:to_do_app/Models/taskmodel.dart';
import 'package:to_do_app/Screens/task_tile.dart';

import 'Addtaskpage.dart';

class TODOPage extends StatefulWidget {
  const TODOPage({Key? key}) : super(key: key);

  @override
  State<TODOPage> createState() => _TODOPageState();
}

class _TODOPageState extends State<TODOPage> with TickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
      lowerBound: -10,
      upperBound: 1,
    )..forward().then((value) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TO DO APP"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(
                          DateTime.now(),
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Today",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                FloatingActionButton.extended(
                  elevation: 0,
                  onPressed: () async {
                    await Get.to(
                      () => const AddTaskPage(),
                    );
                    _taskController.getTasks();
                  },
                  label: const Text("+ ADD TASK"),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
              alignment: Alignment.center,
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectedTextColor: Colors.white,
                selectionColor: Colors.blue,
                onDateChange: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  _showTasks() {
    return Expanded(
      flex: 10,
      child: Obx(() {
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _taskController.taskList.length,
            itemBuilder: (context, i) {
              Task task = _taskController.taskList[i];
              if(task.repeat == 'Daily') {
                return AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(controller.value * -5, controller.value * 0),
                      child: child,
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      _showBottomSheet(context, task);
                    },
                    child: TaskTile(task),
                  ),
                );
              }
              if(task.date == DateFormat.yMd().format(_selectedDate)){
                return AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(controller.value * -5, controller.value * 0),
                      child: child,
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      _showBottomSheet(context, task);
                    },
                    child: TaskTile(task),
                  ),
                );
              }
              else {
              return  Container();
              }
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 5),
        height: 280,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
            const Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.markTaskComplete(task.id!);
                      Get.back();
                    },
                    color: Colors.blue[600]!,
                    context: context,
                  ),
            _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);
                Get.back();
              },
              color: Colors.red[600]!,
              context: context,
            ),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              color: Colors.white,
              isClose: true,
              context: context,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton(
      {required String label,
      required Function()? onTap,
      required Color color,
      required BuildContext context,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true ? Colors.black : color,
          ),
          color: isClose == true ? Colors.transparent : color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
