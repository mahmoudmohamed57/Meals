import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/modules/categories/categories_screen.dart';
import 'package:meals/modules/favorites/favorites_screen.dart';
import 'package:meals/shared/cubit/states.dart';
import 'package:meals/shared/network/local/cache_helper.dart';

class MealsCubit extends Cubit<MealsStates> {
  MealsCubit() : super(MealsInitialState());

  static MealsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = [
    'Categories',
    'Favorites',
  ];

  List<Widget> screens = [
    const CategoriesScreen(),
    const FavoritesScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.star),
      label: 'Favorites',
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(MealsBottomNavBarState());
  }

  bool glutenFree = false;
  bool lactoseFree = false;
  bool vegan = false;
  bool vegetarian = false;

  void setFilters() {
    availableMeals = dummyMeals.where((meal) {
      if (glutenFree && !meal.isGlutenFree) {
        return false;
      }
      if (lactoseFree && !meal.isLactoseFree) {
        return false;
      }
      if (vegan && !meal.isVegan) {
        return false;
      }
      if (vegetarian && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    List<Category> ac = [];
    for (var meal in availableMeals) {
      for (var categoryId in meal.categories) {
        for (var category in dummyCategories) {
          if (categoryId == category.id &&
              !ac.any((cat) => cat.id == categoryId)) {
            ac.add(category);
          }
        }
      }
    }
    availableCategories = ac;
    emit(MealsSetFiltersState());
  }

  void changeGlutenFree(value) {
    glutenFree = value;
    CacheHelper.setBool(key: 'gluten', value: glutenFree);
    emit(MealsChangeGlutenFreeState());
  }

  void changeLactoseFree(value) {
    lactoseFree = value;
    CacheHelper.setBool(key: 'lactose', value: lactoseFree);
    emit(MealsChangeLactoseFreeState());
  }

  void changeVegan(value) {
    vegan = value;
    CacheHelper.setBool(key: 'vegan', value: vegan);
    emit(MealsChangeVeganState());
  }

  void changeVegetarian(value) {
    vegetarian = value;
    CacheHelper.setBool(key: 'vegetarian', value: vegetarian);
    emit(MealsChangeVegetarianState());
  }

  List<Meal> availableMeals = dummyMeals;
  List<Category> availableCategories = dummyCategories;
  List<Meal> favoriteMeals = [];
  List<String> prefFavoriteMealsId = [];

  void toggleFavorite(String mealId) {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefFavoriteMealsId.remove(mealId);
    } else {
      favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      prefFavoriteMealsId.add(mealId);
    }
    CacheHelper.setStringList(
        key: 'prefFavoriteMealsId', value: prefFavoriteMealsId);
    emit(MealsToggleFavoriteState());
  }

  isMealFavorite(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }

  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;
  var tm = ThemeMode.system;
  String themeText = 's';

  void onChanged(newColor, value) {
    value == 1
        ? primaryColor = setToMaterialColor(newColor.value)
        : accentColor = setToMaterialColor(newColor.value);
    CacheHelper.setInt(key: 'primaryColor', value: primaryColor.value);
    CacheHelper.setInt(key: 'accentColor', value: accentColor.value);
    emit(MealsOnChangedState());
  }

  MaterialColor setToMaterialColor(colorValue) {
    return MaterialColor(
      colorValue,
      <int, Color>{
        50: const Color(0xFFFCE4EC),
        100: const Color(0xFFF8BBD0),
        200: const Color(0xFFF48FB1),
        300: const Color(0xFFF06292),
        400: const Color(0xFFEC407A),
        500: Color(colorValue),
        600: const Color(0xFFD81B60),
        700: const Color(0xFFC2185B),
        800: const Color(0xFFAD1457),
        900: const Color(0xFF880E4F),
      },
    );
  }

  void themeModeChange(newThemeValue) {
    tm = newThemeValue;
    getThemeText();
    CacheHelper.setString(key: 'themeText', value: themeText);
    emit(MealsThemeModeChangeState());
  }

  void getThemeText() {
    if (tm == ThemeMode.light) {
      themeText = 'l';
    } else if (tm == ThemeMode.dark) {
      themeText = 'd';
    } else {
      themeText = 's';
    }
  }

  void getData() async {
    glutenFree = CacheHelper.getBool(key: 'gluten') ?? false;
    lactoseFree = CacheHelper.getBool(key: 'lactose') ?? false;
    vegan = CacheHelper.getBool(key: 'vegan') ?? false;
    vegetarian = CacheHelper.getBool(key: 'vegetarian') ?? false;
    prefFavoriteMealsId =
        await CacheHelper.getStringList(key: 'prefFavoriteMealsId') ?? [];
    for (var mealId in prefFavoriteMealsId) {
      final existingIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0) {
        favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      }
    }
    List<Meal> fm = [];
    for (var fMeal in favoriteMeals) {
      for (var aMeal in availableMeals) {
        if (fMeal.id == aMeal.id) {
          fm.add(fMeal);
        }
      }
    }
    favoriteMeals = fm;
    themeText = CacheHelper.getString(key: 'themeText') ?? 's';
    if (themeText == 'l') {
      tm = ThemeMode.light;
    } else if (themeText == 'd') {
      tm = ThemeMode.dark;
    } else {
      tm = ThemeMode.system;
    }
    primaryColor = setToMaterialColor(
        CacheHelper.getInt(key: 'primaryColor') ?? 0xFFE91E63);
    accentColor = setToMaterialColor(
        CacheHelper.getInt(key: 'accentColor') ?? 0xFFFFC107);
    emit(MealsGetDataState());
  }
}
