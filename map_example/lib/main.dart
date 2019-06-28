import 'package:flutter/material.dart';
//import 'notWorking.dart';
import 'working.dart';

void main() => runApp(
  MaterialApp(
    routes: <String, WidgetBuilder>{
    '/': (context) => Working(),
    //'/': (context) => NotWorking(),
    },
    debugShowCheckedModeBanner: false,
  ),
);
