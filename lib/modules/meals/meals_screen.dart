import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/shared/components/components.dart';
import 'package:meals/shared/cubit/cubit.dart';
import 'package:meals/shared/cubit/states.dart';

class MealsScreen extends StatelessWidget {
  static const routeName = 'category_meals';

  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealsCubit, MealsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealsCubit.get(context);
        final routeArguments =
            ModalRoute.of(context)!.settings.arguments as Map<String, String>;
        final categoryId = routeArguments['id'];
        final categoryTitle = routeArguments['title'];
        final meals = cubit.availableMeals.where((meal) {
          return meal.categories.contains(categoryId!);
        }).toList();
        return Scaffold(
          appBar: AppBar(title: Text(categoryTitle!)),
          body: buildListView(meals, context),
        );
      },
    );
  }
}
