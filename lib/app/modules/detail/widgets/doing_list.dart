import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';

import '../../home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
   DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
    ?  Column(
        children: [
          Image.asset('assets/images/task.jpg',fit: BoxFit.cover,
          width: 65.0.wp,),
          Text('Add a task to get started',style: TextStyle(
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold
          ),)
        ],
    )
    :ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        ...homeCtrl.doingTodos.map((e) =>
        Padding(
          padding:  EdgeInsets.symmetric(
            vertical: 3.0.wp,
            horizontal: 9.0.wp
          ),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  fillColor: MaterialStateProperty.resolveWith((states) => Colors.grey),
                  value: e['done'],
                  onChanged: (value) {
                    homeCtrl.doneTodo(e['title']);
                  },
                ),
                
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: Text(e['title'],
                overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )
        ).toList(),
        if(homeCtrl.doingTodos.isNotEmpty)
     Padding(
       padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
       child: const  Divider(
          thickness: 2,
         ),
     )
      ],
    ),
  );
  }
}