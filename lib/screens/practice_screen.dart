import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/controller/main_controller.dart';
import 'package:lexi_learn/screens/components/app_bar.dart';

import '../constant/constant_colors.dart';
import '../models/item.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final MainController controller = Get.find<MainController>();

  @override
  void initState() {
    controller.generateRandomWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(title: 'Practice', goBack: true,
            suffixWidget: TextButton(
              onPressed: () {
                controller.generateRandomWords();
              },
              child: const Text('Generate'),
            ),),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Obx(
                  () => controller.isLoading.value ?
                      CircularProgressIndicator()
                      : ListView.builder(
                    itemCount: controller.randomItemList.length,
                    itemBuilder: (context, index) {
                      bool visible = false;
                      Item item = controller.randomItemList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: const Border(
                                left: BorderSide(
                                    color: ConstantColors.primaryColor,
                                    width: 3)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(1, 2),
                                blurRadius: 5,
                              )
                            ]),
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.burmese,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    Text(
                                      visible ? item.japanese : '-----',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        // fontSize: 16
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () async {
                                      showNoteDialog(context, item);
                                    },
                                    icon: const Icon(
                                        Icons.info_outline, color: Colors.grey)),
                                IconButton(
                                    onPressed: () async {
                                      visible = !visible;
                                      setState(() {});
                                    },
                                    icon: visible ? const Icon(
                                        Icons.visibility, color: ConstantColors.primaryColor) : const Icon(Icons.visibility_off))
                              ],
                            );
                          }
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showNoteDialog(BuildContext context, Item item) {
    showDialog(context: context, builder: (context) {
      return Dialog(
        child: IntrinsicHeight(
          child: Container(
            width: context.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: ConstantColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )
                  ),
                  child: const Text('Note', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Text((item.note?.isNotEmpty ?? false) ? item.note! : 'No note'),
                )

              ],
            ),
          ),
        ),
      );
    });
  }
}
