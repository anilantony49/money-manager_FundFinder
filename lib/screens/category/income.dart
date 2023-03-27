import 'package:flutter/material.dart';

import '../../db/category_db.dart';
import '../../models/category_models.dart';

class IncomePage extends StatelessWidget {
  IncomePage({Key? key}) : super(key: key);

  final editIncometextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().incomeCatogoryNotifier,
        builder:
            (BuildContext context, List<CategoryModels> newValue, Widget? _) {
          return CategoryDb.singleton.incomeCatogoryNotifier.value.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final title = newValue[index];
                          return Card(
                            child: ListTile(
                              title: Text(title.name),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showfoam(context, title.name);
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                    onPressed: () {
                                      CategoryDb().deleteCategory(title.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'An item has been deleted')));
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox();
                        },
                        itemCount: newValue.length,
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text(
                    "Tap the '+' icon to add new items",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                );
        });
  }

  showfoam(BuildContext ctx, String? itemkey) async {
    if (itemkey != null) {
      final existingItem = CategoryDb()
          .incomeCatogoryNotifier
          .value
          .firstWhere((element) => element.name == itemkey);
      editIncometextcontroller.text = existingItem.name;

      showModalBottomSheet(
        context: ctx,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: editIncometextcontroller,
                decoration: const InputDecoration(
                  hintText: 'Edit Income Category',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final updatedItem = CategoryModels(
                    id: existingItem.id,
                    name: editIncometextcontroller.text,
                    type: CategoryType.income,
                  );
                  CategoryDb().editCategory(updatedItem, existingItem.id);
                  Navigator.pop(ctx);
                  CategoryDb()
                      .incomeCatogoryNotifier
                      .value
                      .removeWhere((item) => item.id == existingItem.id);
                  CategoryDb().incomeCatogoryNotifier.value.add(updatedItem);
                  ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                      content: Text('An item has been Updated')));
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
