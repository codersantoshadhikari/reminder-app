import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remind_me/app_themes.dart';
import 'package:remind_me/controllers/task_controller.dart';
import 'package:remind_me/models/task_model.dart';
import 'package:remind_me/screens/home.dart';
import 'package:remind_me/widgets/custom_button.dart';
import 'package:remind_me/widgets/input_field.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key,this.id}) : super(key: key);
 final int? id ;
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TaskController _taskController = Get.put(TaskController());
  FocusNode titleNode = FocusNode();
  late TextEditingController titleController = TextEditingController();
  FocusNode taskBodyNode = FocusNode();
  late TextEditingController taskBodyController = TextEditingController();
  FocusNode dateNode = FocusNode();
  TextEditingController dateController = TextEditingController();
  FocusNode startTimeNode = FocusNode();
  TextEditingController startTimeController = TextEditingController();
  FocusNode remindNode = FocusNode();
  TextEditingController remindController = TextEditingController();
  FocusNode repeatNode = FocusNode();
  TextEditingController repeatController = TextEditingController();
  DateTime date = DateTime.now();
  String _currentTime = DateFormat('hh:mm a').format(DateTime.now());
  int _defaultValue = 5;
  String _repeatMode = 'Never';
  Task? task ;
  List<int> remindList = [5, 10, 15, 20];
  List<String> repeatList = ['never', 'Day', 'Week', 'Month'];
  int _colorIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    dateController.text = DateFormat.yMd().format(date);
    startTimeController.text = _currentTime;
    repeatController.text = _repeatMode;
    titleController.text = 'Untitled';
    remindController.text = '$_defaultValue Minutes';
    widget.id != null ? getTask():
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenH = MediaQuery.of(context).size.height;
    final double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
         widget.id == null? 'Add Task':'Update Task',
          style: AppThemes().subtitleStyle,
        ),
        backgroundColor: context.theme.backgroundColor,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.off(()=>Home());
            },
            icon: Icon(Icons.arrow_back_ios,
                size: 20.0,
                color: Get.isDarkMode ? Colors.white : Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Color',
                          style: AppThemes().labelStyle,
                        ),
                        Wrap(
                          children: List<Widget>.generate(8, (int index) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _colorIndex = index;
                                  });
                                  print(_colorIndex);
                                },
                                child: CircleAvatar(
                                  radius: screenW * 0.032,
                                  backgroundColor: index == 0
                                      ? const Color(0xff648e9a)
                                      : index == 1
                                          ? Color(0xFFFF80A6)
                                          : index == 2
                                              ? Color(0xFF3699EC)
                                              : index == 3
                                                  ? const Color(0xff648e9a)
                                                   : index == 4
                                                  ? Color(0xFFFFC04E)
                                                  :index == 5
                                                 ? const Color(0xff8c0335)
                                                 :index == 6
                                                ?const Color(0xff103b40)
                                                : Color(0xff191A19),
                                  child: index == _colorIndex
                                      ? Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 20.0,
                                        )
                                      : Container(
                                          height: 0,
                                          width: 0,
                                        ),
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                    CustomButton(
                        color: Colors.green,
                        label: widget.id == null?'Save':'Update',
                        onTap: () {
                          _submit();
                         Get.offAll(()=>Home());
                        })
                  ],
                ),
                InputField(
                  textValueController: titleController,
                  node: titleNode,
                  label: 'Title',
                  hint: 'Add Task Title',
                  suffixIcon: Container(
                    height: 0.0,
                    width: 0.0,
                  ),
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return "Don't forget to add Title";
                    }
                    return null;
                  },
                ),
                InputField(
                  textValueController: taskBodyController,
                  node: taskBodyNode,
                  maxLine: 5,
                  label: 'Content',
                  hint: 'Add Task content',
                  suffixIcon: Container(
                    height: 0.0,
                    width: 0.0,
                  ),
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return "Don't forget to add Task to do";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: screenH * 0.08,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        textValueController: dateController,
                        node: dateNode,
                        label: 'Date',
                        hint: '$dateController',
                        suffixIcon: Icon(
                          FontAwesomeIcons.calendar,
                          color: Colors.green,
                        ),
                        onSuffixTap: () {
                          _getDate();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: InputField(
                        textValueController: startTimeController,
                        node: startTimeNode,
                        label: 'Start time',
                        hint: '$_currentTime',
                        suffixIcon: Icon(
                          Icons.watch_later_outlined,
                          color: Colors.green,
                        ),
                        onSuffixTap: () {
                          _getTime();
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        textValueController: remindController,
                        node: remindNode,
                        label: 'Remind me ',
                        hint: '$remindController',
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: _showMinutesList(),
                        ),
                        onSuffixTap: () {},
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: InputField(
                        textValueController: repeatController,
                        node: repeatNode,
                        label: 'Repeat every ',
                        hint: '$repeatController',
                        onValidate: (value) {},
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: _showRepeatList(),
                        ),
                        onSuffixTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    widget.id == null? _uploadTask(): _updateTask();
      _taskController.getTasks();
    }
  }
  _updateTask()async{
    print('id ::: ${widget.id}');
   int value=   await _taskController.updateTask(
        task: Task(
          id: task!.id,
          title: titleController.text,
          content: taskBodyController.text,
          date: dateController.text,
          startTime: startTimeController.text,
          remind: _defaultValue,
          repeat: repeatController.text,
          color: _colorIndex,
          isCompleted: 0,
        ));
   return value;
  }
  _uploadTask() async {
    print(_defaultValue);
    int value = await _taskController.addTask(
        task: Task(
      title: titleController.text,
      content: taskBodyController.text,
      date: dateController.text,
      startTime: startTimeController.text,
      remind: _defaultValue,
      repeat: repeatController.text,
      color: _colorIndex,
      isCompleted: 0,
    ));
    print(value);
  }
 getTask()async{
    task = await _taskController.getTask(widget.id!.toInt());
    setState(() {
      _colorIndex = task!.color!.toInt();
      titleController.text = task!.title.toString();
      taskBodyController.text = task!.content.toString();
      dateController.text = task!.date.toString();
      startTimeController.text = task!.startTime.toString();
      remindController.text='${task!.remind} Minutes';
      repeatController.text = task!.repeat.toString();
    });
 }
  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (_pickerDate != null) {
      setState(() {
        date = _pickerDate;
        dateController.text = DateFormat.yMd().format(date);
      });
    }
  }

  _getTime() async {
    var selectedTime = await _showTimePicker();
    String timeFormat = await selectedTime.format(context);
    if (timeFormat.isEmpty) {
      print('error');
    } else {
      setState(() {
        startTimeController.text = timeFormat;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_currentTime.split(':')[0]),
        minute: int.parse(_currentTime.split(':')[0].split(' ')[0]),
      ),
    );
  }

  _showMinutesList() {
    return DropdownButton(
      borderRadius: BorderRadius.circular(10),
      icon: Icon(
        Icons.keyboard_arrow_down,
        size: 18,
      ),
      style: AppThemes().subtitleStyle,
      underline: Container(),
      onChanged: (String? value) {
        setState(() {
          _defaultValue = int.parse(value!);
          remindController.text = '$_defaultValue Minutes';
        });
      },
      items: remindList.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }

  _showRepeatList() {
    return DropdownButton(
      borderRadius: BorderRadius.circular(10),

      icon: Icon(
        Icons.keyboard_arrow_down,
        size: 18,
      ),
      style: AppThemes().subtitleStyle,
      underline: Container(),
      onChanged: (String? value) {
        _repeatMode = value!;
        setState(() {
          repeatController.text = '$_repeatMode';
        });
      },
      items: repeatList.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
