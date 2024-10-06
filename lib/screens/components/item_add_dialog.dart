import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/controller/main_controller.dart';

import '../../constant/constant_colors.dart';
import '../../models/item.dart';

class ItemAddDialog {
  ItemAddDialog({
    required this.context,
    this.item,
    this.isEdit = false
});

  final BuildContext context;
  Item? item;
  bool isEdit;

  TextEditingController burmese = TextEditingController();
  TextEditingController japanese = TextEditingController();
  TextEditingController note = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final MainController controller = Get.find<MainController>();

  showDialog() {

    if(isEdit) {
      burmese.text = item?.burmese ?? '';
      japanese.text = item?.japanese ?? '';
      note.text = item?.note ?? '';
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return IntrinsicHeight(
            child: Container(
              margin: context.mediaQueryViewInsets,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                     Text(
                      isEdit ? 'Update this word' : 'Add new word',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 32),
                    itemTextField(txtController: burmese, hintText: 'Burmese'),
                    const SizedBox(height: 32),
                    itemTextField(txtController: japanese, hintText: 'Japanese'),
                    const SizedBox(height: 32),
                    itemTextField(
                        txtController: note,
                        hintText: 'Note...',
                        required: false),
                    const SizedBox(height: 32),
                    Obx(
                      () => controller.success.value
                          ? Row(
                              children: [
                                Ink(
                                    width: 20,
                                    height: 20,
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.done,
                                        size: 10, color: Colors.white)),
                                const SizedBox(width: 8),
                                const Text(
                                  'Success',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    const SizedBox(height: 16),
                    isEdit ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              fixedSize: Size(context.width * 0.35, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              await controller.removeItem(item!);
                            }
                          },
                          child: const Text('Delete'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ConstantColors.primaryColor,
                              foregroundColor: Colors.white,
                              fixedSize: Size(context.width * 0.35, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              await controller.updateItem(
                                item!.copyWith(
                                  burmese: burmese.text,
                                  japanese: japanese.text,
                                  note: note.text
                                )
                              );
                              await controller.getVocabs();
                              Get.back();

                            }
                          },
                          child: const Text('Update'),
                        )
                      ],
                    ) :
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColors.primaryColor,
                          foregroundColor: Colors.white,
                          fixedSize: Size(context.width * 0.6, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          await controller.saveItem(
                              Item(
                                  burmese: burmese.text, japanese: japanese.text, note: note.text));
                          burmese.clear();
                          japanese.clear();
                          note.clear();
                        }
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget itemTextField({
    required TextEditingController txtController,
    required String hintText,
    bool required = true,
  }) {
    return TextFormField(
      controller: txtController,
      cursorColor: ConstantColors.primaryColor,
      validator: required
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            }
          : null,
      decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: hintText,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ConstantColors.primaryColor))),
    );
  }
}
