import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/app/core/values/colors.dart';
import 'package:getx_todo_list/app/data/services/storage/models/task.dart';
import 'package:getx_todo_list/app/modules/home/widgets/add_card.dart';
import 'package:getx_todo_list/app/modules/home/widgets/add_dialog.dart';
import 'package:getx_todo_list/app/modules/home/widgets/task_card.dart';

import '../report/view.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          
          children: [
            SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0.wp),
                  child: Text(
                    'My List',
                    style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      ...controller.tasks.map((e) => LongPressDraggable(
                        data: e,
                        onDragStarted: () => controller.changeDeleting(true),
                        onDragEnd: (_) => controller.changeDeleting(false),
                        onDraggableCanceled: (_, __) => controller.changeDeleting(false),
                        feedback: Opacity(opacity: 0.8, child: TaskCard(task: e,),),
                        child: TaskCard(task: e))).toList(),
                      AddCard()
                    ],
                  ),
                ),
              ],
            ),
          ),
          ReportPage(),
          ],
        ),
      ),
      floatingActionButton: DragTarget(

        builder: (_, __, ___) {
          return
          Obx(
          () => FloatingActionButton(
            backgroundColor: controller.deleting.value ? Colors.red : blue,
            onPressed: () {
              if (controller.tasks.isNotEmpty) {
                Get.to(() => AddDialog(), transition: Transition.downToUp);
              } else {
                EasyLoading.showInfo('Please create your task type');
              }
            },
            child:  Icon(controller.deleting.value ? Icons.delete : Icons.add
            ),
          ),
        );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Task deleted successfully');
          
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Padding(
                  padding:  EdgeInsets.only(right: 15.0.wp),
                  child: const Icon(Icons.apps),
                )
              ),
              BottomNavigationBarItem(
                label: 'Report',
                icon: Padding(
                  padding:  EdgeInsets.only(left: 15.0.wp),
                  child: const Icon(Icons.data_usage),
                )
              )
            ],
          
            ),
        ),
      ),
    );
  }
}
