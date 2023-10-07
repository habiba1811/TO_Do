import 'package:flutter/material.dart';
import 'package:to_do/layout/home_layout.dart';
import 'package:to_do/screens/Tasks/edit.dart';
import 'package:to_do/screens/settings.dart';
import 'package:to_do/screens/splash_screen.dart';
import 'package:to_do/screens/Tasks/tasks.dart';
import 'package:to_do/styles/theming.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName:(context)=>SplashScreen(),
        HomeLayout.routeName:(context)=>HomeLayout(),
        TasksTab.routeName:(context)=>TasksTab(),
        SettingsTab.routeName:(context)=>SettingsTab(),
        EditTask.routeName:(context)=>EditTask(),
      },
      themeMode:ThemeMode.light,
      theme: MyThemeData.lightTheme,
    );
  }
}


