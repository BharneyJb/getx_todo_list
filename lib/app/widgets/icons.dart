import 'package:flutter/material.dart';
import 'package:getx_todo_list/app/core/values/colors.dart';
import 'package:getx_todo_list/app/core/values/icons.dart';

List<Icon> getIcons() {
  return const <Icon>[
    Icon(IconData(personIcon, fontFamily: 'MaterialIcons'), color: purple,),
    Icon(IconData(workIcon, fontFamily: 'MaterialIcons'), color: green,),
    Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'), color: yellow,),
    Icon(IconData(sportIcon, fontFamily: 'MaterialIcons'), color: blue,),
    Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'), color: lightBlue,),
    Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'), color:pink,),
  ];
}  