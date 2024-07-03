import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getxtodo/db/db_helper.dart';

import 'package:getxtodo/services/theme_services.dart';
import 'package:getxtodo/ui/screens/HomePage.dart';

import 'package:getxtodo/ui/widgets/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // ignore: deprecated_member_use
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,

      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
