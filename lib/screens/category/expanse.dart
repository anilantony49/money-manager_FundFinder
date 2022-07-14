import 'package:flutter/material.dart';

import '../../db/category_db.dart';


import '../../models/category_models.dart';
import 'category_show_popup.dart';

class ExpansePage extends StatelessWidget {
  const ExpansePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:CategoryDb(). expanseCatogoryNotifier, 
      builder:(BuildContext context, List<CategoryModels> newValue, Widget?_){
      
      return ListView.separated(
          
      itemBuilder: (context, index) {
        final title= newValue[index];
        return Card(
          child: ListTile(
            title: Text(title.name),
            trailing: IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.delete), 
                ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox();
      },
      itemCount: newValue.length,
    );
    
      }
    );
  }
}
