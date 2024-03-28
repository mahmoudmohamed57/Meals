import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/layout/home_layout.dart';
import 'package:meals/modules/filters/filters_screen.dart';
import 'package:meals/modules/meals/meals_screen.dart';
import 'package:meals/modules/meals/meal_screen.dart';
import 'package:meals/modules/on_boarding/on_boarding_screen.dart';
import 'package:meals/modules/themes/themes_screen.dart';
import 'package:meals/shared/cubit/cubit.dart';
import 'package:meals/shared/cubit/states.dart';
import 'package:meals/shared/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool value = CacheHelper.getBool(key: 'watched') ?? false;
  Widget homeScreen = value ? const HomeLayout() : const OnBoardingScreen();
  runApp(
    BlocProvider(
      create: (context) => MealsCubit()
        ..getData()
        ..setFilters(),
      child: MyApp(homeScreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget homeScreen;

  const MyApp(this.homeScreen, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealsCubit, MealsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealsCubit.get(context);
        return MaterialApp(
          themeMode: cubit.tm,
          theme: ThemeData(
            primarySwatch: cubit.primaryColor,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: cubit.primaryColor,
              secondary: cubit.accentColor,
            ),
            canvasColor: const Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            cardColor: Colors.white,
            shadowColor: Colors.white60,
            unselectedWidgetColor: Colors.black87,
            buttonTheme: ButtonThemeData(
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(primary: Colors.black87),
            ),
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyLarge:
                      const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
                  titleLarge: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15.0,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
          darkTheme: ThemeData(
            primarySwatch: cubit.primaryColor,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: cubit.primaryColor,
              secondary: cubit.accentColor,
            ),
            canvasColor: const Color.fromRGBO(14, 22, 33, 1),
            fontFamily: 'Raleway',
            cardColor: const Color.fromRGBO(35, 34, 39, 1),
            shadowColor: Colors.white60,
            unselectedWidgetColor: Colors.white70,
            buttonTheme: ButtonThemeData(
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(primary: Colors.white70),
            ),
            textTheme: ThemeData.dark().textTheme.copyWith(
                  bodyLarge: const TextStyle(color: Colors.white70),
                  titleLarge: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => homeScreen,
            HomeLayout.routeName: (context) => const HomeLayout(),
            MealsScreen.routeName: (context) => const MealsScreen(),
            MealScreen.routeName: (context) => const MealScreen(),
            FiltersScreen.routeName: (context) => const FiltersScreen(),
            ThemesScreen.routeName: (context) => const ThemesScreen(),
          },
        );
      },
    );
  }
}
