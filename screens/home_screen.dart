
import 'package:calismalarim_app/TasksApp/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../data/models/task.dart';
import '../providers/task/task_provider.dart';
import '../widgets/display_list_of_tasks.dark.dart';
import '../widgets/display_white_text.dart';
import 'create_task_screen.dart';

final sliderValueProvider = StateProvider<double>((ref) => 0.0);

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(tasksProvider);
    final sliderValue = ref.watch(sliderValueProvider);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: Colors.redAccent,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Etkinlik Planlayıcı",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListOfTasks(
                      tasks: taskState.tasks,
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final taskState = ref.read(tasksProvider);

                            for (Task task in taskState.tasks) {
                              if (task.isCompleted ) {
                                if(isTaskDatePassed(task)){
                                  await ref.read(tasksProvider.notifier).deleteTask(task);
                                  displaySnackbar(context, 'Tamamlanmış ve tarihi geçmiş etkinlik(ler) silindi');
                                }
                                else{
                                  displaySnackbar(context, 'Bazı etkinliklerin henüz tarihi geçmemiştir.');
                                }
                              }
                            }
                          },
                          child: const DisplayWhiteText(text: "Görev Sil"),
                        ),



                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreateTaskScreen(),
                              ),
                            );
                          },
                          child: const DisplayWhiteText(text: "Yeni Görev Ekle"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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

  bool isTaskDatePassed(Task task) {
    final currentDate = DateTime.now();

    // task.date'i "MMM d, yyyy" formatına çevir
    final taskDate = DateFormat("MMM d, yyyy").parse(task.date);

    // İlgili tarih kontrolü yapılmalı
    return taskDate.isBefore(currentDate);
  }


}
