import 'package:flutter/material.dart';

class ScreenCatagory extends StatefulWidget {

   ScreenCatagory({ Key? key }) : super(key: key);

  @override
  State<ScreenCatagory> createState() => _ScreenCatagoryState();
}

class _ScreenCatagoryState extends State<ScreenCatagory> with SingleTickerProviderStateMixin{
 late TabController _tabController;

 @override
  void initState() {
    _tabController=TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Column(
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
            Text('INCOME'), Text('EXPANSE')
           ],
           controller: _tabController,
           physics: ScrollPhysics(),
           ),
         )
       ],
     );
    
  }
}