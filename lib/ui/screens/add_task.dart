import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getxtodo/controllers/task_controllers.dart';
import 'package:getxtodo/models/task.dart';
import 'package:getxtodo/ui/widgets/button.dart';
import 'package:getxtodo/ui/widgets/input_field.dart';
import 'package:getxtodo/ui/widgets/theme.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskController = Get.put(TaskController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              InputField(
                title: 'Title',
                hint: '   enter something',
                controller: titleController,
              ),
              InputField(
                title: 'Note',
                hint: '   enter Note here',
                controller: noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                    onPressed: () => getDateFromUser(),
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    )),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: ' Start Time',
                      hint: startTime,
                      widget: IconButton(
                          onPressed: () => getTimeFromUser(isStartTime: true),
                          icon: const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      title: ' End Time',
                      hint: endTime,
                      widget: IconButton(
                          onPressed: () => getTimeFromUser(isStartTime: false),
                          icon: const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ],
              ),
              InputField(
                  title: 'Remind',
                  hint: '$_selectedRemind',
                  widget: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ), // Custom arrow icon
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedRemind = newValue!;
                        });
                      },
                      items: remindList.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value minutes early'),
                        );
                      }).toList(),
                    ),
                  )),
              InputField(
                  title: 'Repeat',
                  hint: '$_selectedRepeat',
                  widget: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ), // Custom arrow icon
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                      items: repeatList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('$value'),
                        );
                      }).toList(),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Color',
                        style: TitleStyleheadingStyle,
                      ),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                                3,
                                (index) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedColor = index;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: CircleAvatar(
                                            backgroundColor: index == 0
                                                ? primaryClr
                                                : index == 1
                                                    ? pinkClr
                                                    : orangeClr,
                                            child: _selectedColor == index
                                                ? Icon(Icons.done)
                                                : null),
                                      ),
                                    )),
                          )
                        ],
                      )
                    ],
                  ),
                  MyButton(
                    label: 'Create a Task',
                    onTab: () {
                      _validateDates();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() => AppBar(
        centerTitle: true,
        elevation: 0,
        // ignore: deprecated_member_use
        backgroundColor: context.theme.backgroundColor,
        leading: (IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        )),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/person.jpeg',
            ),
            radius: 40,
          )
        ],
      );

  _addTaskToDB() async {
    int value = await TaskController.addTask(
      task: Task(
          title: titleController.text,
          note: noteController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(selectedDate),
          startTime: startTime,
          endTime: endTime,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          color: _selectedColor),
    );
    print(value);
  }

  _validateDates() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      _addTaskToDB();
      Get.back();
    } else {
      Get.snackbar(
          snackPosition: SnackPosition.BOTTOM,
          'Error',
          'Please fill all the fields',
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
          ));
    }
  }

  getDateFromUser() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedDate = value;
        });
      }
    });
  }

  getTimeFromUser({required bool isStartTime}) {
    showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    ).then((value) {
      if (value != null) {
        setState(() {
          if (isStartTime) {
            startTime = DateFormat.jm().format(DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                value.hour,
                value.minute));
          } else {
            endTime = DateFormat.jm().format(DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                value.hour,
                value.minute));
          }
        });
      }
    });
  }
}
