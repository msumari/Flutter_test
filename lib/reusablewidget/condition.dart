import 'package:flutter/material.dart';

SizedBox conditionTab(IconData icon , String name,int value,String unit) {
 return SizedBox(
   width: 230,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(icon,color: Colors.white,),
        Text(name,style: const TextStyle(color: Colors.white,fontSize: 12),),
        Text(value.toString()+unit,style:const  TextStyle(color: Colors.white,fontSize: 12),),
       
      ],
    ),
  );

 
}