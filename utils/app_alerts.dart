
import 'package:calismalarim_app/TasksApp/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../data/models/task.dart';
import '../providers/task/task_provider.dart';


class AppAlerts {
  const AppAlerts._();

  static displaySnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium,
        ),
        backgroundColor: context.colorScheme.onSecondary,
      ),
    );
  }

  static Future<void> showAlertDeleteDialog({
    required BuildContext context,
    required WidgetRef ref,
    required Task task,
  }) async {
    Widget cancelButton = TextButton(
      child: const Text('Hayır'),
      onPressed: () => context.pop(),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref.read(tasksProvider.notifier).deleteTask(task).then(
              (value) {
            displaySnackbar(
              context,
              'Başarıyla Silindi',
            );
            context.pop();
          },
        );
      },
      child: const Text('Evet'),
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Bu etkinliği silmek mi istiyorsunuz?'),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}