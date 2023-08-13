import 'package:flutter/material.dart';
import 'package:refeicoes/components/meal_item.dart';
import 'package:refeicoes/models/meal.dart';
import '../models/category.dart';

class CategoriesMealsScreen extends StatelessWidget {
  const CategoriesMealsScreen(this.meals, {super.key});

  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    final categoryMeals = meals.where((element) {
      return element.categories.contains(category.id);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(categoryMeals.elementAt(index));
        },
      ),
    );
  }
}
