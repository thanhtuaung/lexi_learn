import 'package:lexi_learn/models/item.dart';
import 'package:lexi_learn/repository/data_repo_interface.dart';

import '../constant/constant_strings.dart';
import 'sqflite_helper.dart';

class ItemDBRepo extends DataRepoInterface {
  final SqfliteHelper _dbHelper = SqfliteHelper();

  @override
  Future<bool> deleteItem(String table, int id) async {
    return await _dbHelper.deleteData(table: table, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Item>> getItems({required String tableName, List<String>? columns, String? where, List<Object?>? whereArgs, String? groupBy, String? orderBy}) async {
    List<Map<String, dynamic>> dataList = await _dbHelper.readData(table: tableName, columns: columns, where: where, whereArgs: whereArgs, groupBy: groupBy, orderBy: orderBy);
    List<Item> items = [];
    if(dataList.isNotEmpty) {
      items = dataList.map((e) => Item.fromJson(e)).toList();
    }
    return items;
  }

  @override
  Future<bool> saveItem(String tableName,Map<String, dynamic> data) async {
    return await _dbHelper.insertData(
        table: tableName, data: data);
  }

  @override
  Future<bool> updateItem({required String table, required Map<String, dynamic> data, String? where, List<Object?>? whereArgs}) async {
    return await _dbHelper.updateData(table: table, data: data, where: where, whereArgs: whereArgs);
  }

}