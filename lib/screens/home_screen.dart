import 'package:finger_auth_demo/data/controllers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserSession userSession = Get.find();
    return Scaffold(
      body: Obx(
        ()=> Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton(
              onPressed: () {
                if (userSession.isFingerPrintEnable.value) {
                  userSession.setIsFingerPrintEnable(false);
                } else {
                  userSession.setIsFingerPrintEnable(true);
                }
              },
              child: Text(
                userSession.isFingerPrintEnable.value ? 'Disable' : 'Enable',
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                userSession.setIsFingerPDisable(true);
                userSession.setIsFingerPrintEnable(false);
              },
              child: const Text(
                'Reset',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
