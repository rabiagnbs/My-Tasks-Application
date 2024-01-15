import 'package:calismalarim_app/TasksApp/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../providers/category_provider.dart';
import '../utils/task_categories.dart';

class SelectCategory extends ConsumerWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = TaskCategories.values.toList();
    final selectedCategory= ref.watch(categoryProvider);
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text('Kategori: ', style: context.textTheme.titleLarge),
      const Gap(10),
          Expanded(child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),

              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index){
            final category = categories[index];
            return InkWell(
              onTap: () {
                ref.read(categoryProvider.notifier).state = category;
              },
               child:  Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: category.color.withOpacity(0.3),
                    border: Border.all(
                      color: category.color,
                    ),
                  ),
                  child: Icon(
                    category.icon,
                    color: category== selectedCategory
                        ? context.colorScheme.primary
                        : category.color,),
                ),
            );
          },
              separatorBuilder: (ctx, index)=> const Gap(10),
              itemCount: categories.length))
        ],
      )
    );

  }
}
