import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Helpers/taskhelpers.dart';
import 'package:to_do_app/Screens/Addtaskpage.dart';
import 'Screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
  runApp(
     GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      routes: {
        "/" : (context) => const TODOPage(),
        "AddTask" : (context) => const AddTaskPage(),
      },
    ),
  );
}
