import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(
  MaterialApp(
    routes: <String, WidgetBuilder>{
      '/': (context) => Home(),
    },
    debugShowCheckedModeBanner: false,
  ),
);
