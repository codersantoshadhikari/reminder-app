import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remind_me/models/task_model.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    Key? key,
    required this.task,
    required this.index,
  }) : super(key: key);

  final Task task;
  final int index;

  @override
  Widget build(BuildContext context) {
    List colors=[0xff648e9a,0xFFFF80A6,0xFF3699EC,0xff648e9a,0xFFFFC04E,0xff8c0335,0xff103b40,0xff191A19];
    final minHeight = getMinHeight(index);
    final double screenH = MediaQuery.of(context).size.height;
    final double screenW = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      color: Color(colors[int.parse(task.color.toString())]),
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,

               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       task.title??"",
                       style: GoogleFonts.lato(
                         textStyle: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                             color: Colors.white),
                       ),
                     ),
                     Text(
                       task.isCompleted == 1 ? "COMPLETED" : "TODO",
                       style: GoogleFonts.lato(
                         textStyle: TextStyle(
                             fontSize: 10,
                             fontWeight: FontWeight.bold,
                             color: Colors.white),
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: screenH*0.005),

                 Text(
                   task.content??"",
                   style: GoogleFonts.lato(
                     textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                   ),
                 ),
               ],
             ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              textBaseline: TextBaseline.ideographic,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: Colors.grey[200],
                  size: 18,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  height: screenH*0.02,
                  width: screenW*0.12,
                  child: AutoSizeText(
                    "${task.startTime}",
                    minFontSize: 10,
                    style: GoogleFonts.lato(
                      textStyle:
                      TextStyle(fontSize: 13, color: Colors.grey[100]),
                    ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenW*0.01),
                  height: 10,
                  width: 1.5,
                  color: Colors.grey[200]!.withOpacity(0.7),
                ),
                Icon(
                  Icons.update,
                  color: Colors.grey[200],
                  size: 18,
                ),
                Container(
                  alignment: Alignment.center,
                  height: screenH*0.02,
                  width: screenW*0.12,
                  child: AutoSizeText(
                    " ${task.repeat}",
                    minFontSize: 10.0,
                    style: GoogleFonts.lato(
                      textStyle:
                      TextStyle(fontSize: 13, color: Colors.grey[100]),
                    ),

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 140;
      case 3:
        return 120;
      default:
        return 130;
    }
  }

}