
import 'package:calismalarim_app/TasksApp/data/repositories/task_repositories.dart';
import 'package:calismalarim_app/TasksApp/data/repositories/task_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasource/task_datasource_provider.dart';


final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final datasource = ref.read(taskDatasourceProvider);
  return TaskRepositoryImpl(datasource);
});