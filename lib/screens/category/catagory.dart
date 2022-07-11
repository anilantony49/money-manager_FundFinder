import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/category/expanse.dart';
import 'package:flutter_application_1/screens/category/income.dart';

class ScreenCatagory extends StatefulWidget {

   ScreenCatagory({ Key? key }) : super(key: key);

  @override
  State<ScreenCatagory> createState() => _ScreenCatagoryState();
}

class _ScreenCatagoryState extends State<ScreenCatagory> with SingleTickerProviderStateMixin{
 late TabController _tabController;
  ValueNotifier<int> bottomNavigation = ValueNotifier(0);
  final textcontroller= TextEditingController();

 @override
  void initState() {
    _tabController=TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
     body: Column(
         children: [
           TabBar(tabs:const [
                Tab(text: 'INCOME',),
                Tab(text: 'EXPANSE',)
           ],
           controller: _tabController
           ,
            indicatorColor:Colors.blue,
            labelColor: Colors.black,
           ),
           Expanded(
             child: TabBarView(children: [
             IncomePage(),ExpansePage()
             ],
             controller: _tabController,
             physics: ScrollPhysics(),
             ),
           ),
        
           
         ],
       ),
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