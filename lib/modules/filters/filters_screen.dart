import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/shared/components/components.dart';
import 'package:meals/shared/cubit/cubit.dart';
import 'package:meals/shared/cubit/states.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = 'filters';
  final bool fromOnBoarding;

  const FiltersScreen({
    super.key,
    this.fromOnBoarding = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealsCubit, MealsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealsCubit.get(context);
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                title: fromOnBoarding ? null : const Text('Your Filters'),
                backgroundColor: fromOnBoarding
                    ? Theme.of(context).canvasColor
                    : Theme.of(context).colorScheme.primary,
                elevation: fromOnBoarding ? 0.0 : 5.0,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Adjust your meal selection',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SwitchListTile(
                    activeTrackColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    activeColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    inactiveThumbColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    value: cubit.glutenFree,
                    onChanged: (value) {
                      cubit.changeGlutenFree(value);
                      cubit.setFilters();
                    },
                    title: Text(
                      'Gluten-free',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: const Text('Only include gluten-free meals.'),
                  ),
                  SwitchListTile(
                    activeTrackColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    activeColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    inactiveThumbColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    value: cubit.lactoseFree,
                    onChanged: (value) {
                      cubit.changeLactoseFree(value);
                      cubit.setFilters();
                    },
                    title: Text(
                      'Lactose-free',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: const Text('Only include lactose-free meals.'),
                  ),
                  SwitchListTile(
                    activeTrackColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    activeColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    inactiveThumbColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    value: cubit.vegan,
                    onChanged: (value) {
                      cubit.changeVegan(value);
                      cubit.setFilters();
                    },
                    title: Text(
                      'Vegan',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: const Text('Only include vegan meals.'),
                  ),
                  SwitchListTile(
                    activeTrackColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    activeColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    inactiveThumbColor:
                        Theme.of(context).buttonTheme.colorScheme!.primary,
                    value: cubit.vegetarian,
                    onChanged: (value) {
                      cubit.changeVegetarian(value);
                      cubit.setFilters();
                    },
                    title: Text(
                      'Vegetarian',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: const Text('Only include vegetarian meals.'),
                  ),
                  SizedBox(height: fromOnBoarding ? 80.0 : 20),
                ]),
              ),
            ],
          ),
          drawer: fromOnBoarding ? null : mainDrawer(context),
        );
      },
    );
  }
}
