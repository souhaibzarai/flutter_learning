import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.text,
  });

  final String? title;
  final List<Meal> meals;
  final String text;

  void onSelectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'uh... oh! nothing here.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
            ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(
          meal: meals[index],
          onSelectMeal: onSelectMeal,
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
