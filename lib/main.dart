import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/database_service.dart';
import 'package:todo_app/models/theme_data.dart';
import 'package:todo_app/models/themes.dart';
import 'package:todo_app/screens/splash_screen.dart';

late SharedPreferences prefs;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DatabaseController().init());
  prefs = await SharedPreferences.getInstance();


  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemesStyle.light,
      darkTheme: ThemesStyle.dark,
      themeMode: ThemeServices().theme,

      home:  Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
