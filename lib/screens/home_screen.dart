import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/constant/constant_colors.dart';
import 'package:lexi_learn/controller/main_controller.dart';
import 'package:lexi_learn/routes.dart';
import 'package:lexi_learn/screens/components/app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final MainController controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(title: 'Home'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Obx(
                    () => buildDashboardCard(
                          title: 'Vocabulary',
                          count: controller.vocabCount.value
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Obx(
                    //   () => buildDashboardCard(
                    //     title: 'Kanji',
                    //     count: controller.kanjiCount.value
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDashboardCard({required String title, required int count}) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.itemListRoute);
      },
      child: Container(
        width: double.infinity,
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ConstantColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: const Offset(1, 2),
                blurRadius: 3,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'Count: $count',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Get.toNamed(Routes.practiceRoute);
                  },
                  child: const Text('Practice'))
            ],
          ),
        ),
      ),
    );
  }
}
