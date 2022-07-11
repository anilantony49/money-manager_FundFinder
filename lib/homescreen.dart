import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/category/catagory.dart';
import 'package:flutter_application_1/screens/transcation.dart';

class ScreenHome extends StatelessWidget {
  ValueNotifier<int> bottomNavigation = ValueNotifier(0);
  final textcontroller= TextEditingController();

  ScreenHome({Key? key}) : super(key: key);

  final _pages = [const ScreenTransaction(),ScreenCatagory(),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                      icon: Icon(Icons.home), label: 'Transacation'),
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
         floatingActionButton:FloatingActionButton(onPressed: (){
          if(bottomNavigation==0){
            print("add transaction");
          }else{
              print("add category");
          }
         showDialog(
          context:(context),
          builder: (context){
           return AlertDialog(
            actions: [
            // title:Text('Add Category'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller:textcontroller ,
                decoration: InputDecoration(
                  hintText: 'Category Name',
                  border: OutlineInputBorder()
                ),
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:ElevatedButton(onPressed: (){}, child:  Text('Add'))
              
            )
            
            ],
            title: Text('Add Category'),
            );
          });
         },
         child: Center(child: Icon(Icons.add),),)
    );
  }
}
