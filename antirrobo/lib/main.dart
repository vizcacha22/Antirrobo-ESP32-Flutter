import 'package:flutter/material.dart';

import 'package:flutter_app/pages/chat.dart';
import 'package:flutter_app/pages/inicio.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: Scaffold(

        body: Chat(),
        // body: Inicio(),

      ),
    );
  }
}
