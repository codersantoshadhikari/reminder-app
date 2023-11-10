import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remind_me/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task? task;
  TaskCard(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _getBGClr(task?.color??0),
      ),
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task?.title??"",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                task?.content??"",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                ),
              ),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: Colors.grey[200],
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${task!.startTime}",
                    style: GoogleFonts.lato(
                      textStyle:
                      TextStyle(fontSize: 13, color: Colors.grey[100]),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 10,
                    width: 1.5,
                    color: Colors.grey[200]!.withOpacity(0.7),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey[200],
                    size: 16,
                  ),
                  Text(
                    " ${task!.date}",
                    style: GoogleFonts.lato(
                      textStyle:
                      TextStyle(fontSize: 13, color: Colors.grey[100]),
                    ),

                  ),
                ],
              ),

            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 60,
          width: 0.5,
          color: Colors.grey[200]!.withOpacity(0.7),
        ),
        RotatedBox(
          quarterTurns: 3,
          child: Text(
            task!.isCompleted == 1 ? "COMPLETED" : "TODO",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.brown;
      case 2:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}