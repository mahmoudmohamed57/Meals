import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meals/layout/home_layout.dart';
import 'package:meals/modules/filters/filters_screen.dart';
import 'package:meals/modules/themes/themes_screen.dart';
import 'package:meals/shared/network/local/cache_helper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    var primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage("assets/images/image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 250.0,
                      height: 50.0,
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 20.0,
                      ),
                      child: const Text(
                        textAlign: TextAlign.center,
                        'Cooking Up!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
              const ThemesScreen(fromOnBoarding: true),
              const FiltersScreen(fromOnBoarding: true),
            ],
            onPageChanged: (val) {
              setState(
                () {
                  currentIndex = val;
                },
              );
            },
          ),
          Indicator(currentIndex),
          Builder(
            builder: (ctx) => Align(
              alignment: const Alignment(0, 0.85),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: MaterialButton(
                  padding: const EdgeInsets.all(7),
                  color: primaryColor,
                  child: Text(
                    'start',
                    style: TextStyle(
                      color: useWhiteForeground(primaryColor)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  onPressed: () async {
                    Navigator.of(ctx)
                        .pushReplacementNamed(HomeLayout.routeName);
                    CacheHelper.setBool(key: 'watched', value: true);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;

  const Indicator(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(context, 0),
          buildContainer(context, 1),
          buildContainer(context, 2),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext ctx, int i) {
    return index == i
        ? Icon(
            Icons.star,
            color: Theme.of(ctx).colorScheme.primary,
          )
        : Container(
            margin: const EdgeInsets.all(4),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Theme.of(ctx).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
          );
  }
}
