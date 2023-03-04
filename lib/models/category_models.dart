
import 'package:hive_flutter/adapters.dart';
part 'category_models.g.dart';
@HiveType(typeId: 2)
enum CategoryType{
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}
@HiveType(typeId: 1)
class CategoryModels{
 @HiveField(0)
 final String id;
  @HiveField(1)
  final  String name;
  @HiveField(2)
 final bool isDeleted;
  @HiveField(3)
 final CategoryType type;

  CategoryModels({required this.id,required this.name, this.isDeleted=false, required this.type});


@override
  String toString() {
    
    return '{$name $type}';
    
  }
}

