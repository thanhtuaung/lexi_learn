import 'package:lexi_learn/constant/constant_strings.dart';

enum ItemType {
  vocap(ConstantStrings.vocabTable),
  kanji(ConstantStrings.kanjiTable);

  final String table;

  const ItemType(this.table);
}

enum FilterTab { all, favourite }