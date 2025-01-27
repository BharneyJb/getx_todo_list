import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:getx_todo_list/app/data/services/storage/repository.dart';

import '../../data/services/storage/models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final chipIndex = 0.obs;
  final tasks = <Task>[].obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    editCtrl.dispose();
    super.onClose();
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask( Task? select){
    task.value = select;
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      }else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  updateTask(Task task, String title){
    var todos = task.todos ?? [];
    if (containTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containTodo(List todos, String title) {
    return todos.any((e) => e == title);
  }

 bool addTodo(String title) {
   var  todo = {'title': title, 'done': false};
   if (doingTodos.any((e) => mapEquals<String, dynamic>(todo, e))) {
     return false;
   }
   var doneTodo = {'title': title, 'done': true};
   if (doneTodos.any((e) => mapEquals<String, dynamic>(doneTodo, e))) {
     return false;
   }
   doingTodos.add(todo);  
    return true; 
  }

  void updateTodos(){
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
      ...doneTodos,
      ]);
      var newTask = task.value!.copyWith(todos: newTodos);
      int oldIdx = tasks.indexOf(task.value);
      tasks[oldIdx] = newTask;
      tasks.refresh();
  }

  void doneTodo(String title) {
    var doingTodo = {'title': title, 'done': false};
    int index = doingTodos.indexWhere((e) => mapEquals<String, dynamic>(doingTodo, e));
    doingTodos.removeAt(index);
    var doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();

  }

  void deleteDoneTodo(dynamic doneTodo) {
    int index = doneTodos.indexWhere((e) => 
    mapEquals<String, dynamic>(doneTodo, e));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }


  bool isTodosEmpty(){
    return task.value?.todos == null || task.value!.todos!.isEmpty;
  }

  int getDoneTodo(Task task) {
    var res = 0;
    for (int i = 0; i < task.todos!.length; i++) {
      if(task.todos![i]['done'] == true) {
        res += 1;
      }
  }
  return res;
  }

}
