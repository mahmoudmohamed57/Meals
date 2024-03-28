import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/shared/components/components.dart';
import 'package:meals/shared/cubit/cubit.dart';
import 'package:meals/shared/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealsCubit, MealsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealsCubit.get(context);
        if (cubit.favoriteMeals.isEmpty) {
          return const Center(
            child: Text('You have no favorites yet - start adding some!'),
          );
        } else {
          return buildListView(cubit.favoriteMeals, context);
        }
      },
    );
  }
}
