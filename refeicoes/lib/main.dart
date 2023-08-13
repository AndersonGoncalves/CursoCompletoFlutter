import 'package:flutter/material.dart';
import 'package:refeicoes/data/dummy_data.dart';
import 'package:refeicoes/models/meal.dart';
import 'package:refeicoes/models/settings.dart';
import 'package:refeicoes/screens/settings_screen.dart';
import 'package:refeicoes/screens/meal_detail_screen.dart';
import 'package:refeicoes/screens/tabs_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/categories_meals_screen.dart';
import 'utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();

  List<Meal> _availableMaels = dummyMeals;
  final List<Meal> _favoriteMaels = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMaels = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMaels.contains(meal)
          ? _favoriteMaels.remove(meal)
          : _favoriteMaels.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMaels.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      //Inicio - Difinindo o thema da aplicação //ou theme: ThemeData(primarySwatch: Colors.purple),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.pink,
          secondary: Colors.amber,
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      //Fim - Difinindo o thema da aplicação
      //home: const CategoriesScreen(), //Não precisa pois foi adicionado o home na rota
      //initialRoute: '/',
      routes: {
        AppRoutes.home: (ctx) =>
            TabsScreen(_favoriteMaels), //CategoriesScreen(),
        AppRoutes.categoriesMeals: (ctx) =>
            CategoriesMealsScreen(_availableMaels),
        AppRoutes.mealDetail: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.settings: (ctx) => SettingsScreen(settings, _filterMeals),
      },
      /*
      onGenerateRoute: (settings) {
        if (settings == '/alguma-coiisa') {
          return null;
        } else if (settings == '/outra-coisa') {
          return null;
        } else {
          return MaterialPageRoute(builder: (_) {
            return const CategoriesScreen();
          });
        }
      },
      */
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) {
            return const CategoriesScreen(); //pode criar uma pagina de erro
          },
        );
      },
    );
  }
}
