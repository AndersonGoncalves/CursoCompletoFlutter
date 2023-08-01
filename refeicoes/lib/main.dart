import 'package:flutter/material.dart';
import 'package:refeicoes/components/settings_screen.dart';
import 'package:refeicoes/screens/meal_detail_screen.dart';
import 'package:refeicoes/screens/tabs_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/categories_meals_screen.dart';
import 'utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        AppRoutes.home: (ctx) => const TabsScreen(), //CategoriesScreen(),
        AppRoutes.categoriesMeals: (ctx) => const CategoriesMealsScreen(),
        AppRoutes.mealDetail: (ctx) => const MealDetailScreen(),
        AppRoutes.settings: (ctx) => const SettingsScreen(),
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
