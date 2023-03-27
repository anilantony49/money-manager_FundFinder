import 'package:hive_flutter/adapters.dart';

import 'category_models.dart';
part 'transaction_models.g.dart';

@HiveType(typeId: 3)
class transactionModels {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final String purpose;
  @HiveField(3)
  final bool isDeleted;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  final CategoryType type;
  @HiveField(6)
  final CategoryModels model;

  transactionModels(
      {required this.id,
      required this.amount,
      required this.purpose,
      required this.isDeleted,
      required this.date,
      required this.type,
      required this.model});
}
