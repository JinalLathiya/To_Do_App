import 'package:flutter/material.dart';
import 'package:to_do_app/Models/taskmodel.dart';

class TaskTile extends StatelessWidget {
  final Task? task;

  TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5,),
      padding: const EdgeInsets.symmetric(horizontal: 20,),
      height: 150,
      width: 390,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _getBGclr(task?.color ?? 0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    task?.title ?? "",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.access_alarms_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${task!.Stime} - ${task!.Etime}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Text(
                    task?.note ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 100,
              width: 0.8,
              color: Colors.black,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task!.isCompleted == 1 ? "COMPLETED" : "TO DO",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBGclr(int no) {
    switch (no) {
      case 0:
        return Colors.cyan;
      case 1:
        return Colors.pinkAccent;
      case 2:
        return Colors.blueAccent;
      default:
        return Colors.white;
    }
  }
}
