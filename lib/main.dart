import 'package:flutter/material.dart';
import 'package:globo_app/data/moor_db.dart';
import 'package:globo_app/screens/settings.dart';
import './screens/home.dart';
import './data/moor_db.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => BlogDb(),
      child: MaterialApp(
        title: 'GlobeApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
