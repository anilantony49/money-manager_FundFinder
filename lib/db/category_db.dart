import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category_models.dart';
import 'package:hive_flutter/adapters.dart';

final _CATEGORY_DB_NAME= 'categoryDB';

ValueNotifier<List<CategoryModels>> CategoryModelsNotifier=ValueNotifier([]);

abstract class CategoryDbfunctions{
Future< List<CategoryModels>>getCategories();
 
 Future<void>insertCategory(CategoryModels value);

  
}

class CategoryDb implements CategoryDbfunctions{
  @override
  Future<void> insertCategory(CategoryModels value)async {
 final _categoryDB=  await  Hive.openBox<CategoryModels>(_CATEGORY_DB_NAME);
 CategoryModelsNotifier.value.clear();
 CategoryModelsNotifier.value.addAll(_categoryDB.values);
 CategoryModelsNotifier.notifyListeners();
 await _categoryDB.add(value);
   
  }

  @override
  Future<List<CategoryModels>> getCategories() async {
   final _categoryDB=  await  Hive.openBox<CategoryModels>(_CATEGORY_DB_NAME);
   return  _categoryDB.values.toList();

  }
  
} 


