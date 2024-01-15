
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/task_categories.dart';

final categoryProvider = StateProvider.autoDispose<TaskCategories>((ref){
  return TaskCategories.other;
});