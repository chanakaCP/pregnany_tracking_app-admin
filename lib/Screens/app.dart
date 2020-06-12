import 'package:flutter/material.dart';

import 'adminScreen.dart';
import 'babysDev/babysDev.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mama na Mwana",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: AdminScreen(),
      initialRoute: '/adminHome',
      routes: {
        '/adminHome': (context) => AdminScreen(),
        '/baby': (context) => BabysDev(),
      },
    );
  }
}
