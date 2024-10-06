import 'package:flutter/material.dart';

import '../../constant/constant_colors.dart';

class AppBarWidget extends StatelessWidget {
   AppBarWidget({super.key, required this.title, this.goBack = false, this.suffixWidget});

  final String title;
  bool goBack;
  Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: ConstantColors.primaryColor, width: 2),
          )
      ),
      child: Row(
        children: [
          if(goBack)
            const BackButton(),
          Text(title,
            style: const TextStyle(
                color: ConstantColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 25
            ),),
          const Spacer(),
          suffixWidget ?? const SizedBox()
        ],
      ),
    );
  }
}
