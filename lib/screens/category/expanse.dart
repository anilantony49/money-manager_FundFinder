import 'package:flutter/material.dart';
import '../../db/category_db.dart';
import '../../models/category_models.dart';

class ExpansePage extends StatelessWidget {
  ExpansePage({
    Key? key,
  }) : super(key: key);
  final editExpansetextcontroller = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expanseCatogoryNotifier,
        builder:
            (BuildContext context, List<CategoryModels> newValue, Widget? _) {
          return CategoryDb.singleton.expanseCatogoryNotifier.value.isNotEmpty
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
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        CategoryDb().deleteCategory(title.id);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'An item has been deleted')));
                                      },
                                      icon: const Icon(Icons.delete)),
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
          .expanseCatogoryNotifier
          .value
          .firstWhere((element) => element.name == itemkey);
      editExpansetextcontroller.text = existingItem.name;

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
                controller: editExpansetextcontroller,
                decoration: const InputDecoration(
                  hintText: 'Edit Expanse Category',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final updatedItem = CategoryModels(
                    id: existingItem.id,
                    name: editExpansetextcontroller.text,
                    type: CategoryType.expense,
                  );
                  CategoryDb().editCategory(updatedItem, existingItem.id);
                  Navigator.pop(ctx);
                  CategoryDb()
                      .expanseCatogoryNotifier
                      .value
                      .removeWhere((item) => item.id == existingItem.id);
                  CategoryDb().expanseCatogoryNotifier.value.add(updatedItem);
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
