import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_page.dart';
import 'screens/splashscreen.dart'; // Import the login page

void main() {
  runApp(
     MyShopApp(),
  );
}

class MyShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => CustomSplashScreen(),
        //'/home': (context) => HomePage(),
      },
    );
  }
}
