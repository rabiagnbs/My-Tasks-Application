
import 'package:calismalarim_app/TasksApp/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../data/datasource/task_datasource.dart';
import '../data/models/task.dart';
import '../data/repositories/task_repository_impl.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({super.key, required this.task, this.onCompleted});
  final Task task;
  final Function(bool?)? onCompleted;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    tasks.add(widget.task);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final style= context.textTheme;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(9.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.task.category.color.withOpacity(0.3),
                  border: Border.all(
                      width: 2,
                      color: widget.task.category.color,
                  )
              ),
              child: Center(
                child: Icon(
                    widget.task.category.icon,
                    color: widget.task.category.color),
              )
          ),

          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(widget.task.date),
                const Gap(8),
                Text(widget.task.time),
              ],
            ),
          ),

          Column(
            children: [
              Text(widget.task.title),
              const Gap(7),
              Slider(
                min: 0,
                max: 100,
                value: widget.task.katilimci_sayisi.toDouble(),
                onChanged: null,
              ),
            ],
          ),
          Checkbox(
            value: tasks.first.isCompleted,
            onChanged: (bool? newValue) async {
              print("Checkbox onChanged: $newValue");
              if (newValue != null) {
                TaskRepositoryImpl taskRepository = TaskRepositoryImpl(TaskDatasource());
                Task updatedTask = tasks.first.copyWith(isCompleted: newValue);
                await taskRepository.updateTask(updatedTask);
                setState(() {
                  tasks = [updatedTask];
                });
              }
            },
          )
        ],
      ),
    );
  }
}
