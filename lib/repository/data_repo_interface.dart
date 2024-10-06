abstract class DataRepoInterface {
  saveItem(String tableName,Map<String, dynamic> data);

  updateItem(
      { required String table,
        required Map<String, dynamic> data,
        String? where,
        List<Object?>? whereArgs});

  deleteItem(String table, int id);

  getItems({
    required String tableName,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? orderBy,
  });
}