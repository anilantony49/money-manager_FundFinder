import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/category_db.dart';
import 'package:flutter_application_1/screens/category/expanse.dart';
import 'package:flutter_application_1/screens/category/income.dart';

enum Category { income, expense }

class ScreenCatagory extends StatefulWidget {
  const ScreenCatagory({Key? key}) : super(key: key);

  @override
  State<ScreenCatagory> createState() => _ScreenCatagoryState();
}

class _ScreenCatagoryState extends State<ScreenCatagory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ValueNotifier<int> bottomNavigation = ValueNotifier(0);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(
                text: 'INCOME',
              ),
              Tab(
                text: 'EXPANSE',
              )
            ],
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.black,
          ),
        
          Expanded(
            child: TabBarView(
              children: [IncomePage(), ExpansePage()],
              controller: _tabController,
              physics: const ScrollPhysics(),
            ),
          ),
        ],
      ),
      //  floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (bottomNavigation.value == 0) {
      //       print("add transaction");
      //     } else {
      //       print("add category");
      //     }
      //   },
      //   child: const Center(
      //     child: Icon(Icons.add),
      //   ),
      // )
    );
  }
}
