
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../data/models/task.dart';
import '../providers/category_provider.dart';
import '../providers/date_provider.dart';
import '../providers/task/task_provider.dart';
import '../providers/time_provider.dart';
import '../routes/route_location.dart';
import '../utils/app_alerts.dart';
import '../utils/helpers.dart';
import '../widgets/common_text_field.dart';
import '../widgets/display_white_text.dart';
import '../widgets/select_category.dart';
import '../widgets/select_date_time.dart';



class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key, this.controller});
  final TextEditingController? controller;

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  double _sliderValue = 0;
  List<Task> tasks = [];// Added to store the value of the Slider

  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DisplayWhiteText(text: "Yeni Görev Ekle"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              CommonTextField(
                title: 'Etkinlik Adı',
                hintText: 'Etkinlik Adı',
                controller: _titleController,
              ),
              const Gap(10),
              Text("Katılımcı Sayısı", style: TextStyle(fontSize: 20)),
              const Gap(5),
              Slider(
                min: 0,
                max: 100,
                value: _sliderValue,
                label: _sliderValue.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
              const Gap(20),
              SelectCategory(),
              const Gap(20),
              SelectDateTime(),
              const Gap(20),
              CommonTextField(
                title: 'Etkinlik Notu',
                hintText: 'Etkinlik Notu',
                maxLines: 5,
                controller: _noteController,
              ),
              const Gap(20),
              ElevatedButton(onPressed: _createTask, child: Text('Kaydet')),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);
    final category = ref.watch(categoryProvider);
    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        category: category,
        time: Helpers.timeToString(time),
        date: DateFormat.yMMMd().format(date),
        note: note,
        isCompleted: false,
        katilimci_sayisi: _sliderValue.toInt(),
      );

      await ref.read(tasksProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackbar(context, 'Görev Başarıyla Eklendi');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackbar(context, 'Görev Maalesef eklenemedi');
    }
  }

}