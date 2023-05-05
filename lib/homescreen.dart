import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/category/catagory.dart';
import 'package:flutter_application_1/screens/category/category_show_popup.dart';
import 'package:flutter_application_1/screens/transaction/transcation.dart';

class ScreenHome extends StatelessWidget {
  ValueNotifier<int> bottomNavigation = ValueNotifier(0);
  final textcontroller = TextEditingController();

  ScreenHome({Key? key}) : super(key: key);

  final _pages = [
    const ScreenTransaction(),
    const ScreenCatagory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
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
              showCategoryAddPopUp(context);
              print("add category");
            }
          },
          child: const Center(
            child: Icon(Icons.add),
          ),
        ));
  }
}
