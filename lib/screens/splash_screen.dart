import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/constant/constant_colors.dart';
import 'package:lexi_learn/controller/main_controller.dart';

class SplashScreen extends GetView<MainController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text('LL',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: ConstantColors.primaryColor
            ),),
            Text('Lexis Learn', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
            Text('Practice make perfect'),
            Spacer(),
            Text('Powered by'),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Text('Than Htoo Aung'),
            ),
          ],
        ),
      ),
    );
  }
}
