import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/category_db.dart';
import 'package:flutter_application_1/models/category_models.dart';
import 'package:flutter_application_1/screens/category/expanse.dart';
import 'package:flutter_application_1/screens/category/income.dart';

enum Category {income,expense}
class ScreenCatagory extends StatefulWidget {

   ScreenCatagory({ Key? key }) : super(key: key);
   

  @override
  State<ScreenCatagory> createState() => _ScreenCatagoryState();
  
}

class _ScreenCatagoryState extends State<ScreenCatagory> with SingleTickerProviderStateMixin{
 
 Category?_category=Category.income;
 late TabController _tabController;
  ValueNotifier<int> bottomNavigation = ValueNotifier(0);
 
  // String income='Income';

 

 @override
  void initState() {
    _tabController=TabController(length: 2, vsync: this);
    CategoryDb().getCategories().then((value){
      print('Category value');
      print( value.toString());
    });
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
             child: TabBarView(children: const [
             IncomePage(),ExpansePage()
             ],
             controller: _tabController,
             physics: const ScrollPhysics(),
             ),
           ),
        
           
         ],
       ),
          floatingActionButton:FloatingActionButton(onPressed: (){
          if(bottomNavigation.value==0){
            print("add transaction");
          }else{
              print("add category");
             
          }
        
         },
         child: Center(child: Icon(Icons.add),),
         )
     );
    
  }
}