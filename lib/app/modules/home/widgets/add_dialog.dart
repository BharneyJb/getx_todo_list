import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';

import '../controller.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        
        
        return false;
      },
      child: Scaffold(
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.editCtrl.clear();
                        homeCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          if(homeCtrl.task.value == null){
                            EasyLoading.showError('Please select a task type');
                        } else{
                          var success = homeCtrl.updateTask(
                            homeCtrl.task.value!,
                            homeCtrl.editCtrl.text,
                          );
                          if (success) {
                            EasyLoading.showSuccess('Todo item added');
                            Get.back();
                            homeCtrl.changeTask(null);
      
                        } else{
                          EasyLoading.showError('Todo item already exists');
                        }
                        homeCtrl.editCtrl.clear();
                        }
                      }
                    },  
                      child: Text('Done', style: TextStyle(fontSize: 14.0.sp)),
                    )
                  ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                'New Task',
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editCtrl,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
              child: Text(
                'Add to',
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
            ...homeCtrl.tasks
                .map(
                  (e) => Obx(
                    () => InkWell(
                      onTap: () {
                        homeCtrl.changeTask(e);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp,
                          horizontal: 5.0.wp,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                    IconData(e.icon, fontFamily: 'MaterialIcons'),
                                    color: HexColor.fromHex(e.color)),
                                SizedBox(
                                  width: 3.0.wp,
                                ),
                                Text(
                                  e.title,
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (homeCtrl.task.value == e)
                              const Icon(Icons.check, color: Colors.blue)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList()
          ]),
        ),
      ),
    );
  }
}
