import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meals/shared/components/components.dart';
import 'package:meals/shared/cubit/cubit.dart';
import 'package:meals/shared/cubit/states.dart';

class ThemesScreen extends StatelessWidget {
  static const routeName = 'Themes';
  final bool fromOnBoarding;

  const ThemesScreen({
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
                title: fromOnBoarding ? null : const Text('Your Themes'),
                backgroundColor: fromOnBoarding
                    ? Theme.of(context).canvasColor
                    : Theme.of(context).colorScheme.primary,
                elevation: fromOnBoarding ? 0.0 : 5.0,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Adjust your themes selection',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Choose your Theme Mode',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    RadioListTile(
                      title: const Text('System Default Theme'),
                      value: ThemeMode.system,
                      groupValue: cubit.tm,
                      onChanged: (value) {
                        cubit.themeModeChange(value);
                      },
                    ),
                    RadioListTile(
                      secondary: Icon(
                        Icons.wb_sunny_outlined,
                        color:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                      ),
                      title: const Text('Light Theme'),
                      value: ThemeMode.light,
                      groupValue: cubit.tm,
                      onChanged: (value) {
                        cubit.themeModeChange(value);
                      },
                    ),
                    RadioListTile(
                      secondary: Icon(
                        Icons.nights_stay_outlined,
                        color:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                      ),
                      title: const Text('Dark Theme'),
                      value: ThemeMode.dark,
                      groupValue: cubit.tm,
                      onChanged: (value) {
                        cubit.themeModeChange(value);
                      },
                    ),
                    buildLastSection(context, 'primary', cubit),
                    buildLastSection(context, 'accent', cubit),
                    SizedBox(height: fromOnBoarding ? 80.0 : 20),
                  ],
                ),
              ),
            ],
          ),
          drawer: fromOnBoarding ? null : mainDrawer(context),
        );
      },
    );
  }

  ListTile buildLastSection(context, txt, MealsCubit cubit) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return ListTile(
      title: Text(
        'Choose your $txt color',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      trailing: CircleAvatar(
        backgroundColor:
            txt == 'primary' ? cubit.primaryColor : cubit.accentColor,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              elevation: 4.0,
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(0.0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor:
                      txt == 'primary' ? cubit.primaryColor : cubit.accentColor,
                  onColorChanged: (value) {
                    cubit.onChanged(value, txt == 'primary' ? 1 : 2);
                  },
                  colorPickerWidth: isLandscape ? 150.0 : 300.0,
                  pickerAreaHeightPercent: isLandscape ? 1.0 : 0.7,
                  enableAlpha: false,
                  // displayThumbColor: true,
                  labelTypes: const [],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
