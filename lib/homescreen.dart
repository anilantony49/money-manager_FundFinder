import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/category/catagory.dart';
import 'package:flutter_application_1/screens/category/category_show_popup.dart';
import 'package:flutter_application_1/screens/transaction/transaction_show_textfield.dart';
import 'package:flutter_application_1/screens/transaction/transcation.dart';

import 'db/category_db.dart';

import 'models/category_models.dart';

class ScreenHome extends StatelessWidget {
  ValueNotifier<int> bottomNavigation = ValueNotifier(0);
  final textcontroller = TextEditingController();

  ScreenHome({Key? key}) : super(key: key);

  final _pages = [
    ScreenTransaction(),
    const ScreenCatagory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('FundFinder'),
          centerTitle: true,
        ),
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: bottomNavigation,
            builder: (BuildContext context, int index, Widget? _) {
              return BottomNavigationBar(
                  currentIndex: index,
                  onTap: (index) {
                    bottomNavigation.value = index;
                    print(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Transaction'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.category), label: 'Category'),
                  ]);
            }),
        body: SafeArea(
            child: ValueListenableBuilder(
                builder: (BuildContext context, int index, Widget? _) {
                  return _pages[index];
                },
                valueListenable: bottomNavigation),
                
                ),
                
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (bottomNavigation.value == 0) {
              Navigator.pushNamed(context, 'first');

              print("add category");
            } else {
              ShowCategoryAddPopUp(context);
              print("add category");
              // final _value = CategoryModels(
              //     id: DateTime.now().millisecondsSinceEpoch.toString(),
              //     name: 'travel',
              //     type: CategoryType.expense);
              // CategoryDb().insertCategory(_value);

              //  print(_value);
            }
            ;
          },
          child: const Center(
            child: Icon(Icons.add),
          ),
        ));
  }
}
