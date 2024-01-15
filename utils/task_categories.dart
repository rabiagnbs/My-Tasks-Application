import 'dart:ui';
import 'package:flutter/material.dart';

enum TaskCategories{
  education(Icons.school, Colors.indigoAccent),
  health(Icons.favorite, Colors.red),
  home(Icons.home, Colors.cyan),
  other(Icons.calendar_month, Colors.deepPurple),
  homework(Icons.work_history, Colors.green),
  shopping(Icons.shopping_basket_sharp, Colors.blueGrey),
  social(Icons.emoji_people_outlined, Colors.amber);

  static TaskCategories stringToTaskCategory(String name) {
    try {
      return TaskCategories.values.firstWhere(
            (category) => category.name == name,
      );
    } catch (e) {
      return TaskCategories.other;
    }
  }

  final IconData icon;
  final Color color;
  const TaskCategories(this.icon, this.color);

}