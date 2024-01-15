
import 'package:calismalarim_app/TasksApp/providers/task/task_notifer.dart';
import 'package:calismalarim_app/TasksApp/providers/task/task_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/task_repository_provider.dart';


final tasksProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});