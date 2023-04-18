import 'package:flutter/material.dart';

import 'package:login2/screens/listaTarea.dart';
import 'package:login2/screens/login_screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: {
        'Login': (_) => Login(),
        'Home': (_) => ListaTareas(),
      },
      initialRoute: 'Login',
    );
  }
}
