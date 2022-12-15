import 'package:finger_auth_demo/data/controllers/user_session.dart';
import 'package:finger_auth_demo/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  UserSession userSession = Get.put(UserSession());
  userSession.init();
  print('IsEnable ---> ${userSession.isFingerPrintEnable}');
  print('IsDisable ---> ${userSession.isFingerPDisable}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
