import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/category_db.dart';
import 'package:flutter_application_1/models/category_models.dart';

final textcontroller = TextEditingController();
ValueNotifier<CategoryType> selectedCategoryType =
    ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopUp(context) async {
  showDialog(
      context: (context),
      builder: (ctx) {
        return SimpleDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: textcontroller,
                decoration: const InputDecoration(
                    hintText: 'Category Name', border: OutlineInputBorder()),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    RadioButton(title: 'Income', type: CategoryType.income),
                    RadioButton(title: 'Expanse', type: CategoryType.expense)
                  ],
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                    onPressed: () {
                      final _name = textcontroller.text;
                      if (_name.isEmpty) {
                        return;
                      }
                      final _type = selectedCategoryType.value;
                      final category = CategoryModels(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: _name,
                          type: _type);
                      CategoryDb.singleton.insertCategory(category);
                      print(category.toString());
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Add'))),
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryType,
          builder:
              (BuildContext context, CategoryType newCatagorytype, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: newCatagorytype,
              onChanged: (value) {
                selectedCategoryType.value = value!;
                selectedCategoryType.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
