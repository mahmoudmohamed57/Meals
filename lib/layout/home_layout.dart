import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/shared/components/components.dart';
import 'package:meals/shared/cubit/cubit.dart';
import 'package:meals/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  static const routeName = 'home-layout';

  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealsCubit, MealsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealsCubit.get(context);
        cubit.getData();
        return Scaffold(
          appBar: AppBar(title: Text(cubit.titles[cubit.currentIndex])),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor:
                Theme.of(context).buttonTheme.colorScheme!.primary,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
          drawer: mainDrawer(context),
        );
      },
    );
  }
}
