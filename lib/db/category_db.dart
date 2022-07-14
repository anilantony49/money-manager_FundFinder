import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category_models.dart';
import 'package:hive_flutter/adapters.dart';

import '../screens/category/category_show_popup.dart';

final _CATEGORY_DB_NAME= 'categoryDB';


abstract class CategoryDbfunctions{
Future< List<CategoryModels>>getCategories();


 
 Future<void>insertCategory(CategoryModels value);

  
}

class CategoryDb implements CategoryDbfunctions{
  ValueNotifier<List<CategoryModels>> incomeCatogoryNotifier=ValueNotifier([]);
ValueNotifier<List<CategoryModels>> expanseCatogoryNotifier=ValueNotifier([]);

   CategoryDb._internal();
  static final CategoryDb singleton = CategoryDb._internal();

  factory CategoryDb() {
    return singleton;
  }

  


  @override
  Future<void> insertCategory(CategoryModels value)async {
 final _categoryDB=  await  Hive.openBox<CategoryModels>(_CATEGORY_DB_NAME);

 await _categoryDB.add(value);
 refreshUI();
   
  }

  @override
  Future<List<CategoryModels>> getCategories() async {
   final _categoryDB=  await  Hive.openBox<CategoryModels>(_CATEGORY_DB_NAME);
   return  _categoryDB.values.toList();

  }


  Future<void>refreshUI()async {
final _allCategories=await getCategories();
  incomeCatogoryNotifier.value.clear();
   expanseCatogoryNotifier.value.clear();
 await Future.forEach(_allCategories, (CategoryModels category){
  if(category.type==CategoryType.income){
   incomeCatogoryNotifier.value.add(category);
    
  }else{
     expanseCatogoryNotifier.value.add(category);
     
  }
 });
   incomeCatogoryNotifier.notifyListeners();
   expanseCatogoryNotifier.notifyListeners();
  }
  
} 


