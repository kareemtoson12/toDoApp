import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodo/ui/widgets/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required this.payload});
  final String payload;
  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payLoad = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _payLoad = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          _payLoad.toString().split('|')[0],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr),
        ),
        centerTitle: true,
        elevation: 0,
        // ignore: deprecated_member_use
        backgroundColor: bluishClr,
        leading: (IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        )),
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Text(
                'hiii nigger',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Get.isDarkMode ? darkGreyClr : Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'You have new reminder',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Get.isDarkMode ? darkGreyClr : Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
            margin: const EdgeInsets.only(left: 30, right: 30),
            decoration: BoxDecoration(
                color: primaryClr, borderRadius: BorderRadius.circular(30)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.text_format,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Title',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _payLoad.toString().split('|')[0],
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.description,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _payLoad.toString().split('|')[1],
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.justify,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'date',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    _payLoad.toString().split('|')[2],
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          )),
          const SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }
}
