import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/modules/meals/meals_screen.dart';
import 'package:meals/shared/cubit/cubit.dart';
import 'package:meals/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealsCubit, MealsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealsCubit.get(context);
        return GridView(
          padding: const EdgeInsets.all(25.0),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
          ),
          children: cubit.availableCategories
              .map(
                (category) => InkWell(
                  splashColor: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      MealsScreen.routeName,
                      arguments: {
                        'id': category.id,
                        'title': category.title,
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        colors: [
                          category.color,
                          category.color.withOpacity(0.5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      category.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
