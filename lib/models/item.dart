import 'package:lexi_learn/models/enum.dart';

class Item {
  int? id;
  final String burmese;
  final String japanese;
  // final ItemType itemType;
  String? note;
  bool favourite;
  bool isActive;

  Item({
    this.id,
    required this.burmese,
    required this.japanese,
    // required this.itemType,
    this.note,
    this.favourite = false,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'burmese': burmese,
      'japanese': japanese,
      'note': note,
      'is_favourite': favourite ? 1: 0,
      'is_active': isActive ? 1: 0,
    };
  }

  factory Item.fromJson(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      burmese: map['burmese'],
      japanese: map['japanese'],
      note: map['note'],
      favourite: map['is_favourite'] == 1,
      isActive: map['is_active'] == 1,
    );
  }

  Item copyWith({
    int? id,
    String? burmese,
    String? japanese,
    String? note,
    bool? favourite,
    bool? isActive,
  }) {
    return Item(
      id: id ?? this.id,
      burmese: burmese ?? this.burmese,
      japanese: japanese ?? this.japanese,
      note: note ?? this.note,
      favourite: favourite ?? this.favourite,
      isActive: isActive ?? this.isActive,
    );
  }
}