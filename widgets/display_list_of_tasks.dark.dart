import 'package:calismalarim_app/TasksApp/utils/extensions.dart';
import 'package:calismalarim_app/TasksApp/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/task.dart';
import '../providers/task/task_provider.dart';
import '../utils/app_alerts.dart';
import 'common_container.dart';


class DisplayListOfTasks extends ConsumerWidget {
  const DisplayListOfTasks({
    super.key,
    this.isCompletedTasks = false,
    required this.tasks,
  });
  final bool isCompletedTasks;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height =
    isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emptyTasksAlert = isCompletedTasks
        ? 'Heniz bir Etkinlik yok'
        : 'Heniz Bir Etkinlik Yok';

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
        child: Text(
          emptyTasksAlert,
          style: context.textTheme.headlineSmall,
        ),
      )
          : ListView.separated(
        shrinkWrap: true,
        itemCount: tasks.length,
        padding: EdgeInsets.zero,
        itemBuilder: (ctx, index) {
          final task = tasks[index];

          return InkWell(
            onLongPress: () async {
              await AppAlerts.showAlertDeleteDialog(
                context: context,
                ref: ref,
                task: task,
              );
            },

            child: TaskTile(
              task: task,
              onCompleted: (value) async {
                await ref
                    .read(tasksProvider.notifier)
                    .updateTask(task)
                    .then((value) {
                  AppAlerts.displaySnackbar(
                    context,
                    task.isCompleted
                        ? 'Etkinlik Tamamlanamadı'
                        : 'Etkinlik Tamamlandı',
                  );
                });
              },
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          thickness: 1.5,
        ),
      ),
    );
  }
}