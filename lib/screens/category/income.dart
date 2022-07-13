import 'package:flutter/material.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context,index){
        return const ListTile(
          title:Text('income category'),
        trailing: Icon(Icons.delete,color: Colors.red,),
        );
      }, 
      separatorBuilder: (context,index){
        return SizedBox();
      }, 
      itemCount: 10
    );
  }
}