import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category_models.dart';

final textcontroller = TextEditingController();
ValueNotifier<CategoryType> SelectedCategoryType =
    ValueNotifier(CategoryType.income);
void ShowCategoryAddPopUp(context) {
  showDialog(
      context: (context),
      builder: (context) {
        return SimpleDialog(
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
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    RadioButton(title: 'Income', type: CategoryType.income),
                    RadioButton(title: 'Expanse', type: CategoryType.expense)
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                ElevatedButton(onPressed: () {

                  
                }, child: const Text('Add'))),
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: SelectedCategoryType,
          builder:
              (BuildContext context, CategoryType newCatagorytype, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: newCatagorytype,
              onChanged: (value) {
                SelectedCategoryType.value = value!;
                SelectedCategoryType.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
