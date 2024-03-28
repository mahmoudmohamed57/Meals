import 'package:flutter/material.dart';
import 'package:meals/layout/home_layout.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/modules/filters/filters_screen.dart';
import 'package:meals/modules/meals/meal_screen.dart';
import 'package:meals/modules/themes/themes_screen.dart';

Widget buildSectionTitle(context, text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20.0),
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    ),
  );
}

Widget buildContainer(child, context) {
  var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
  var dw = MediaQuery.of(context).size.width;
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    ),
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.all(10.0),
    height: 170.0,
    width: isLandscape ? dw * 0.5 - 30 : dw,
    child: child,
  );
}

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[600],
    );

Widget buildListTile(title, icon, tapHandler, BuildContext context) {
  return ListTile(
    leading: Icon(
      icon,
      size: 25.0,
      color: Theme.of(context).buttonTheme.colorScheme!.primary,
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color,
        fontSize: 25.0,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.bold,
      ),
    ),
    onTap: tapHandler,
  );
}

Widget mainDrawer(context) {
  return Drawer(
    elevation: 0.0,
    child: Column(
      children: [
        Container(
          height: 120.0,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).colorScheme.secondary,
          child: Text(
            'Cooking Up!',
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'RobotoCondensed',
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        buildListTile(
          'Meals',
          Icons.restaurant,
          () {
            Navigator.pushReplacementNamed(context, HomeLayout.routeName);
          },
          context,
        ),
        buildListTile(
          'Filters',
          Icons.settings,
          () {
            Navigator.pushReplacementNamed(context, FiltersScreen.routeName);
          },
          context,
        ),
        buildListTile('Themes', Icons.color_lens, () {
          Navigator.pushReplacementNamed(context, ThemesScreen.routeName);
        }, context),
      ],
    ),
  );
}

Widget buildListView(meals, context) {
  var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
  var dw = MediaQuery.of(context).size.width;
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: dw <= 400 ? 400 : 500,
      childAspectRatio: isLandscape ? dw / (dw * 0.9) : dw / (dw * 0.8),
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
    ),
    itemBuilder: (ctx, index) => InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(
              MealScreen.routeName,
              arguments: meals[index].id,
            )
            .then((mealId) {});
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4.0,
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    //meals[index].imageUrl,
                  ),
                  child: SizedBox(
                    height: 200.0,
                    width: double.infinity,
                    child: Hero(
                      tag: meals[index].id,
                      child: InteractiveViewer(
                        child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/images/photo.png'),
                          image: NetworkImage(meals[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  right: 10.0,
                  child: Container(
                    width: 290.0,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    child: Text(
                      meals[index].title,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        '${meals[index].duration} min',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        complexityText(meals[index].complexity),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        affordabilityText(meals[index].affordability),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    itemCount: meals.length,
  );
}

String complexityText(complexity) {
  if (Complexity.simple == complexity) {
    return 'Simple';
  } else if (Complexity.challenging == complexity) {
    return 'Challenging';
  } else {
    return 'Hard';
  }
}

String affordabilityText(affordability) {
  if (Affordability.affordable == affordability) {
    return 'Affordable';
  } else if (Affordability.pricey == affordability) {
    return 'Pricey';
  } else {
    return 'Luxurious';
  }
}
