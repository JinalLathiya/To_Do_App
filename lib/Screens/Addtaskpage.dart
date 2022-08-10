import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/Controllers/task_controllers.dart';
import 'package:to_do_app/Screens/feilds.dart';

import '../Models/taskmodel.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime selectedDate = DateTime.now();
  String endtime = "9:30 PM";
  String starttime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String selectRemind = "5";
  List<int> Remindlist = [
    5,
    10,
    15,
    20,
  ];
  String selectRepeat = "None";
  List<String> Repeatlist = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  int selectedColor = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TaskController _taskController = Get.put(
    TaskController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyInputFields(
                title: "Title",
                hint: "Enter Title Here",
                controller: _titleController,
              ),
              MyInputFields(
                title: "Note",
                hint: "Enter Note Here",
                controller: _noteController,
              ),
              MyInputFields(
                title: "Date",
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _pickDate();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputFields(
                      title: "Start Time",
                      hint: starttime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_alarms_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _picktime(
                            isstarttime: true,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyInputFields(
                      title: "End Time",
                      hint: endtime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_alarms_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _picktime(
                            isstarttime: false,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              MyInputFields(
                title: "Reminder",
                hint: "$selectRemind minutes earlier",
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
                    size: 30,
                  ),
                  underline: Container(
                    height: 0,
                  ),
                  items: Remindlist.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(
                        value.toString(),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectRemind = value!;
                    });
                  },
                ),
              ),
              MyInputFields(
                title: "Repeat",
                hint: selectRepeat,
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
                    size: 30,
                  ),
                  underline: Container(
                    height: 0,
                  ),
                  items:
                      Repeatlist.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value!,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectRepeat = value!;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(
                          "Color",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Wrap(
                        children: List<Widget>.generate(
                          3,
                          (int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColor = index;
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: index == 0
                                      ? Colors.cyan
                                      : index == 1
                                          ? Colors.pinkAccent
                                          : index == 2
                                              ? Colors.blueAccent
                                              : Colors.white,
                                  child: selectedColor == index
                                      ? const Icon(
                                          Icons.done_rounded,
                                          color: Colors.black,
                                          size: 20,
                                        )
                                      : Container(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: FloatingActionButton.extended(
                      elevation: 0,
                      onPressed: () {
                        _validateDate();
                      },
                      label: const Text("CREATE TASK"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (_picker != null) {
      setState(() {
        selectedDate = _picker;
      });
    } else {
      print("Something Went Wrong .. !!");
    }
  }

  _picktime({required bool isstarttime}) async {
    var pickedTime = await _showtimepicker();
    String formattime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Canceled");
    } else if (isstarttime == true) {
      setState(() {
        starttime = formattime;
      });
    } else if (isstarttime == false) {
      setState(() {
        endtime = formattime;
      });
    }
  }

  _showtimepicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(starttime.split(":")[0]),
        minute: int.parse(starttime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskDb();
      Get.back();
    } else if (_titleController.text.isEmpty && _noteController.text.isEmpty) {
      Get.snackbar(
        "Alert",
        "Fill The All Fields .. !!",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey[600],
        icon: const Icon(
          Icons.warning_rounded,
          size: 22,
          color: Colors.white,
        ),
      );
    }
  }

  _addTaskDb() async {
   int value = await  _taskController.addTask(
        task: Task(
      title: _titleController.text,
      note: _noteController.text,
      date: DateFormat.yMd().format(selectedDate),
      Stime: starttime,
      Etime: endtime,
      isCompleted: 0,
      remind: selectRemind,
      color: selectedColor,
      repeat: selectRepeat,
    ));
   print("My id is $value");
  }
}
