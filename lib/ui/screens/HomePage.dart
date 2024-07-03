import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getxtodo/controllers/task_controllers.dart';
import 'package:getxtodo/models/task.dart';
import 'package:getxtodo/services/notification_services.dart';
import 'package:getxtodo/services/theme_services.dart';
import 'package:getxtodo/ui/screens/add_task.dart';
import 'package:getxtodo/ui/screens/notification_screen.dart';

import 'package:getxtodo/ui/widgets/button.dart';
import 'package:getxtodo/ui/widgets/task_tail.dart';
import 'package:getxtodo/ui/widgets/theme.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyhelper;

  @override
  void initState() {
    super.initState();
    notifyhelper = NotifyHelper();
    notifyhelper.requestIosPermissions();
    notifyhelper.initializeNotification();
    taskController.getTasks();
  }

  DateTime selectedDate = DateTime.now();
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: appBar(),
      body: Column(
        children: [
          addTaskBar(),
          addDateBar(),
          const SizedBox(height: 6),
          Expanded(
              child:
                  showTasks()), // Ensure the tasks are properly expanded to fit the remaining space.
        ],
      ),
    );
  }

  AppBar appBar() => AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Get.isDarkMode
                ? const Icon(Icons.wb_sunny_outlined)
                : const Icon(Icons.nightlight_round_outlined),
            onPressed: () {
              ThemeServices().switchTheme();
            },
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/person.jpeg'),
            radius: 40,
          )
        ],
      );

  addTaskBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat().add_yMMMd().format(DateTime.now()),
                  style: SubheadingStyle,
                ),
                Text(
                  'Today',
                  style: headingStyle,
                )
              ],
            ),
            MyButton(
              label: '+ Add Task',
              onTab: () async {
                await Get.to(const AddTaskPage());
                taskController.getTasks();
              },
            )
          ],
        ),
      ),
    );
  }

  addDateBar() {
    return Container(
      width: 320,
      height: 100,
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dateTextStyle: const TextStyle(color: Colors.grey, fontSize: 18),
        dayTextStyle: const TextStyle(color: Colors.grey, fontSize: 18),
        monthTextStyle: const TextStyle(color: Colors.grey, fontSize: 18),
        onDateChange: (newDate) {
          setState(() {
            selectedDate = newDate;
          });
        },
      ),
    );
  }

  showTasks() {
    return Expanded(
      child: Obx(() {
        if (taskController.taskList.isEmpty) {
          return _noTaskmsg();
        } else {
          return Container(
            child: ListView.builder(
              itemCount: taskController.taskList.length,
              itemBuilder: (context, index) {
                var task = taskController.taskList[index];
                if (task.date == DateFormat.yMd().format(selectedDate) ||
                    task.repeat == 'Daily') {
                  // Show daily tasks
                } else if (task.repeat == 'Weekly' &&
                    selectedDate
                                .difference(DateFormat.yMd().parse(task.date!))
                                .inDays %
                            7 ==
                        0) {
                  // Show weekly tasks
                } else if (task.repeat == 'Monthly' &&
                    DateFormat.yMd().parse(task.date!).day ==
                        selectedDate.day) {
                  // Show monthly tasks
                } else {
                  return Container();
                }
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1375),
                  child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: TaskTail(task: task),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }

  _buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 65,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[200]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? TitleStyleheadingStyle
                : TitleStyleheadingStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(4),
          width: MediaQuery.of(context).size.width,
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                ),
              ),
              const SizedBox(height: 20),
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomSheet(
                      label: 'Task Completed',
                      onTap: () {
                        // Handle task completion logic here
                        taskController.markUsCompleted(task.id!);
                        Get.back();
                      },
                      clr: primaryClr,
                    ),
              _buildBottomSheet(
                label: 'Delete Task',
                onTap: () {
                  // Handle task deletion logic here
                  taskController.deleteTasks(task);
                  Get.back();
                },
                clr: pinkClr,
              ),
              Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
              _buildBottomSheet(
                label: 'Cancel',
                onTap: () {
                  Get.back();
                },
                clr: Colors.red,
                isClose: true,
              ),
              _buildBottomSheet(
                label: 'Details',
                onTap: () {
                  // Handle showing task details here
                  Get.to(NotificationScreen(
                      payload: '${task.title}|${task.note}|${task.date}'));
                },
                clr: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _noTaskmsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(microseconds: 2000),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 90),
                SvgPicture.asset(
                  'assets/images/task.svg',
                  color: primaryClr.withOpacity(0.5),
                  height: 90,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'You don\'t have any tasks yet',
                    style: SubtitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
