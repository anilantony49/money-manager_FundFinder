import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/catagory.dart';
import 'package:flutter_application_1/screens/transcation.dart';

class ScreenHome extends StatelessWidget {
  ValueNotifier<int> bottomNavigation = ValueNotifier(0);

  ScreenHome({Key? key}) : super(key: key);

  final _pages = [const ScreenTransaction(),ScreenCatagory(),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('MONEY MANAGER'),
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
                      icon: Icon(Icons.home), label: 'Transcation'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category), label: 'Category'),
                  
                ]);
          }),
      body: SafeArea(
        child: ValueListenableBuilder(
          builder:(BuildContext context, int index, Widget?_){
            return _pages[index];
          } ,
          valueListenable:bottomNavigation )),
    );
  }
}
