import 'package:equatable/equatable.dart';

import '../../utils/task_categories.dart';
import '../../utils/task_keys.dart';

class Task extends Equatable {
  final int? id;
  final String title;
  final String note;
  final TaskCategories category;
  final String time;
  final String date;
  final bool isCompleted;
  final int katilimci_sayisi;
  const Task(
       {
    this.id,
    required this.title,
    required this.category,
    required this.time,
    required this.date,
    required this.note,
    required this.isCompleted,
    required this.katilimci_sayisi,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      TaskKeys.id: id,
      TaskKeys.title: title,
      TaskKeys.note: note,
      TaskKeys.category: category.name,
      TaskKeys.time: time,
      TaskKeys.date: date,
      TaskKeys.isCompleted: isCompleted ? 1 : 0,
      TaskKeys.katilimci_sayisi: katilimci_sayisi,
    };
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      id: map[TaskKeys.id],
      title: map[TaskKeys.title],
      note: map[TaskKeys.note],
      category: TaskCategories.stringToTaskCategory(map[TaskKeys.category]),
      time: map[TaskKeys.time],
      date: map[TaskKeys.date],
      isCompleted: map[TaskKeys.isCompleted] == 1 ? true : false,
      katilimci_sayisi:  map[TaskKeys.katilimci_sayisi],
    );
  }

  @override
  List<Object> get props {
    return [
      title,
      note,
      category,
      time,
      date,
      isCompleted,
      katilimci_sayisi,
    ];
  }

  Task copyWith({
    int? id,
    String? title,
    String? note,
    TaskCategories? category,
    String? time,
    String? date,
    bool? isCompleted,
    int? katilimci_sayisi,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      category: category ?? this.category,
      time: time ?? this.time,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      katilimci_sayisi: katilimci_sayisi ?? this.katilimci_sayisi,
    );
  }
}