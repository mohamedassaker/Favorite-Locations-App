import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:provider/provider.dart';

import 'home_widget.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Location Apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
    ),
      home: Home(),
    );
  }
}