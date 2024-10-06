import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/constant/constant_colors.dart';
import 'package:lexi_learn/controller/main_controller.dart';
import 'package:lexi_learn/models/enum.dart';
import 'package:lexi_learn/models/item.dart';
import 'package:lexi_learn/screens/components/app_bar.dart';
import 'package:lexi_learn/screens/components/item_add_dialog.dart';

class ItemListScreen extends StatelessWidget {
  ItemListScreen({super.key});

  final MainController controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              AppBarWidget(title: 'Vocabulary', goBack: true),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: Row(
                  children: FilterTab.values.map((tab) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        controller.selectedTab.value = tab;
                        controller.filterItems();
                      },
                      child: Obx(
                          () => Chip(
                          label: Text(tab.name),
                          backgroundColor: tab == controller.selectedTab.value ?  ConstantColors.primaryColor : Colors.white,
                          labelStyle: TextStyle(color: tab == controller.selectedTab.value ? Colors.white : Colors.grey),
                          side: const BorderSide(color: ConstantColors.primaryColor),
                        ),
                      ),
                    ),
                  ),).toList(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: controller.vocabList.length,
                      // separatorBuilder: (context, index) {
                      //   return Divider(color: ConstantColors.primaryColor);
                      // },
                      itemBuilder: (context, index) {
                        Item vocab = controller.vocabList[index];
                        return InkWell(
                          onTap: () {
                            ItemAddDialog(
                                    context: context, item: vocab, isEdit: true)
                                .showDialog();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            width: double.infinity,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: const Border(
                                    left: BorderSide(
                                        color: ConstantColors.primaryColor,
                                        width: 3)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    offset: const Offset(1, 2),
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vocab.burmese,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    Text(
                                      vocab.japanese,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        // fontSize: 16
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await controller.updateItem(
                                          vocab.copyWith(
                                              favourite: !vocab.favourite));
                                      await controller.filterItems();

                                    },
                                    icon: vocab.favourite
                                        ? const Icon(Icons.star,
                                            color: ConstantColors.primaryColor)
                                        : const Icon(
                                            Icons.star_border_purple500_sharp))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ConstantColors.primaryColor,
          foregroundColor: Colors.white,
          onPressed: () {
            showAdderDialog(context);
          },
          child: const Icon(Icons.add),
        ));
  }

  showAdderDialog(BuildContext context) {
    ItemAddDialog(context: context).showDialog();
  }
}
