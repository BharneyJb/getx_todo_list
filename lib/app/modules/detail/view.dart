import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/app/modules/detail/widgets/doing_list.dart';
import 'package:getx_todo_list/app/modules/detail/widgets/done_list.dart';
import 'package:getx_todo_list/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailPage({super.key});

  @override
/*************  ✨ Codeium Command ⭐  *************/
/// Builds the detail page widget for displaying and managing a specific task.
///
/// This widget constructs a page with a task form, including functionalities to
/// view, add, and update todo items associated with a task. It displays the task
/// icon, title, and a progress indicator representing completed todos. It
/// includes two lists for ongoing and completed tasks, and allows users to
/// add new todo items via a text input field.
///
/// The widget uses `WillPopScope` to prevent navigation back with the device's
/// back button. A `Scaffold` serves as the main structure, and the `Form` widget
/// manages the validation and submission of new todo items. The page is reactive
/// to changes in the task's state using GetX's `Obx` for state management.
///
/// Returns a `WillPopScope` widget containing a `Scaffold` with a task form.

/******  b5da7f41-1d5c-4bc9-99b3-2b071805e1be  *******/
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
      
                          homeCtrl.updateTodos();
                          homeCtrl.changeTask(null);
                          homeCtrl.editCtrl.clear();
                        },
                        icon: const Icon(Icons.arrow_back))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Icon(
                      IconData(task.icon, fontFamily: 'MaterialIcons'),
                      color: color,
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                          fontSize: 12.0.wp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Obx(() {
                var totalTodos =
                    homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                    left: 16.0.wp,
                    top: 3.0.wp,
                    right: 16.0.wp,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '$totalTodos Tasks',
                        style: TextStyle(fontSize: 20.0.wp, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 3.0.wp,
                      ),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: homeCtrl.doneTodos.length,
                          size: 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [color.withOpacity(0.5), color],
                          ),
                          unselectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey[300]!, Colors.grey[300]!],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.0.wp,
                  horizontal: 5.0.wp,
                ),
                child: TextFormField(
                  controller: homeCtrl.editCtrl,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (
                            homeCtrl.formKey.currentState!.validate()
                          ){
                            var success = homeCtrl.addTodo(homeCtrl.editCtrl.text);
                            if (success) {
                              EasyLoading.showSuccess('Todo item add success');
                            } else {
                              EasyLoading.showError('Todo item already exists');
                            }
                            homeCtrl.editCtrl.clear();
                          }
                        }, icon: const Icon(Icons.done)),
                  ),
                  validator: (value) {
                    if(value == null || value.trim().isEmpty) {
                      return 'Please enter your todo item';
                    }
                    return null;
                  },
                ),
              ),
              DoingList(),
              DoneList(),
            ],
          ),
        ),
      ),
    );
  }
}
