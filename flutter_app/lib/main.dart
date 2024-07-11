import 'package:flutter/material.dart';
import 'package:safezone/inicio.dart';
import 'package:safezone/main_page.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "SAFEZONE Background Service",
    notificationText: "Your app is running in the background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'), // Replace with your app's icon
  );

  await FlutterBackground.initialize(androidConfig: androidConfig);
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid, 
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Inicio(),
        '/protection': (context) => MainPage(),
      },
    );
  }
}
