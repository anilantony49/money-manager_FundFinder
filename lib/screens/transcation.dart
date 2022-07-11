import 'package:flutter/material.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder: (context,index){
        return  Card(
          elevation: 0,
          child: ListTile(
            title:Text('1000') ,
            subtitle: Text('travel'),
            leading:CircleAvatar(
              child: Text('12\ndec',
              textAlign: TextAlign.center,),
              backgroundColor: Colors.red,
              radius: 50,),
              trailing: IconButton(
                onPressed: (){}, 
                icon: Icon(Icons.delete,
                color: Colors.red,
               
           
          ),))
        );
      }, 
      separatorBuilder: (context,index){
        return Divider();
      }, 
      itemCount: 10);
  }
}