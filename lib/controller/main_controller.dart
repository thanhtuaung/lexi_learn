import 'dart:math';

import 'package:get/get.dart';
import 'package:lexi_learn/constant/constant_strings.dart';
import 'package:lexi_learn/models/enum.dart';
import 'package:lexi_learn/models/item.dart';
import 'package:lexi_learn/repository/item_db_repo.dart';
import 'package:lexi_learn/routes.dart';

class MainController extends GetxController {
  final ItemDBRepo _itemDBRepo = ItemDBRepo();
  RxList<Item> vocabList = List<Item>.of([]).obs;
  RxList<Item> kanjiList = List<Item>.of([]).obs;
  RxList<Item> randomItemList = List<Item>.of([]).obs;

  RxInt vocabCount = 0.obs;
  RxInt kanjiCount = 0.obs;

  RxBool success = false.obs;
  RxBool isLoading = false.obs;

  Rx<FilterTab> selectedTab = FilterTab.all.obs;
  ItemType itemType = ItemType.vocap;

  @override
  void onInit() {
    loadData();
    getVocabs();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(Routes.homeRoute);
  }

  saveItem(Item item) async {

    bool isSuccess = await _itemDBRepo.saveItem(itemType.table, item.toJson());
    if(isSuccess) {
      changeSuccessStatus();
      if(itemType == ItemType.vocap) {
        await getVocabs();
      } else {

      }
    }
  }

  removeItem(Item item) async {
    _itemDBRepo.deleteItem(itemType.table, item.id ?? 0)
    .then((isSuccess) async {
      if(isSuccess) {
        Get.back();
        await getVocabs();
      }
    });
  }

  updateItem(Item item) async {
    await _itemDBRepo.updateItem(table: itemType.table, data: item.toJson(), where: 'id = ?', whereArgs: [item.id])
    .then((isSuccess) async {
      if(isSuccess) {
        changeSuccessStatus();
      }
    });
    return true;
  }

  getVocabs() async {
    List<Item> vocabs = await _itemDBRepo.getItems(tableName: ConstantStrings.vocabTable);
    vocabList.value = vocabs;
    vocabCount.value = vocabList.length;
  }

  filterItems() async {
    if(itemType == ItemType.vocap) {
      if(selectedTab.value == FilterTab.favourite) {
        await getFavouriteItems();
      } else {
        await getVocabs();
      }
    } else {
      if(selectedTab.value == FilterTab.favourite) {
        kanjiList.value = kanjiList.where((kanji) => kanji.favourite == true).toList();
      } else {
        // getVocabs();
      }
    }
  }

  getFavouriteItems() async {
    List<Item> vocabs = await _itemDBRepo.getItems(tableName: ConstantStrings.vocabTable, where: 'is_favourite = ?', whereArgs: [1]);
    vocabList.value = vocabs;
  }

  generateRandomWords() async {
    List<Item> randomItems = [];
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));

    if(vocabList.length < 11) {
      print(vocabList.length);
      randomItemList.value = vocabList;
    } else {
      for(int i=0; i < 10; i++) {
        int randomNum = Random().nextInt(vocabCount.value);
        Item item = vocabList[randomNum];
        randomItems.add(item);
      }
      randomItemList.value = randomItems;
    }
    isLoading.value = false;
  }

  changeSuccessStatus() {
    success.value = true;
    Future.delayed(const Duration(milliseconds: 1500), () {
      success.value = false;
    });
  }
}