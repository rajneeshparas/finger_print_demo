import 'dart:async';
import 'dart:io';

import 'package:biometric_fingerprint/biometric_fingerprint.dart';
import 'package:biometric_fingerprint/biometric_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/controllers/user_session.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  UserSession userSession = Get.find();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var _duration = const Duration(seconds: 6);
    return Timer(_duration, navigateNewScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }

  navigateNewScreen() async {
    if (!userSession.isFingerPDisable.value) {
      if (userSession.isFingerPrintEnable.value) {
        ///TODO: Authenticate Biometric
        checkFingerPrint().then((value) {
          if (value) {
            Get.offAll(() => const HomeScreen());
          } else {
            exit(0);
          }
        });
      } else {
        ///TODO: Request finger print
        Get.offAll(() => const HomeScreen());
        // showAlertDialog(context);
      }
    } else {
      ///TODO: Biometric is disabled
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
        userSession.setIsFingerPrintEnable(false);
        Get.offAll(() => const HomeScreen());
      },
    );
    Widget continueButton = TextButton(
      child: Text("Enable"),
      onPressed: () {
        Navigator.pop(context);
        checkFingerPrint().then((value) {
          if (value) {
            userSession.setIsFingerPrintEnable(true);
            userSession.setIsFingerPDisable(false);
            Get.offAll(() => const HomeScreen());
          }
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Enable Biometric!"),
      content: Text("Please enable Biometric Authentication!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> checkFingerPrint() async {
    BiometricType type = await BiometricFingerprint.type;
    print('The Auth Type is ${type}');
    bool isBiometricEnabled = await BiometricFingerprint.isEnabled;
    print('The Auth is Enable =  $isBiometricEnabled');

    BiometricResult result = await BiometricFingerprint().initAuthentication(
      biometricKey: 'RJ',
      message: 'Test message.',
      title: 'This is test title.',
      subtitle: 'This is subtitle.',
      description: 'This is test description.',
      negativeButtonText: 'Use Password',
      confirmationRequired: true,
    );

    if (result.status == BiometricStatus.SUCCESS) {
      return true;
    }
    return false;
  }
}
