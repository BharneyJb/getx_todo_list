import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';

import '../../../core/values/colors.dart';
import '../../home/controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
 DoneList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Obx(
      () => homeCtrl.doneTodos.isNotEmpty ?
      ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 2.0.wp),
            child: Text('Completed(${homeCtrl.doneTodos.length})',
            style: TextStyle(fontSize: 14.0.sp,
            color: Colors.grey,)
            ),
          ),
          ...homeCtrl.doneTodos.map((e) => 
          Dismissible(
            key: ObjectKey(e),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => homeCtrl.deleteDoneTodo(e),
            background: Container(
              color: Colors.red.withOpacity(0.8),
              alignment: Alignment.centerRight,
              child: Padding(
                padding:  EdgeInsets.only(right: 5.0.wp),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 9.0.wp, vertical: 3.0.wp),
              child: Row(
                children: [
                const  SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(Icons.done,
                    color: blue,
                    ),
                 ),
                 Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 4.0.wp),
                   child: Text(e['title'],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        
                    ),
                               ),
                 )
                ]
              ),
            ),
          ),
          )
        ],
      ) : Container()
    );
  }
}