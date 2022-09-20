import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';

import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoritesScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "No favorite meals yet, it is time to start adding!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            title: favoriteMeals[index].title,
            imageURL: favoriteMeals[index].imageUrl,
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity,
            duration: favoriteMeals[index].duration,
            id: favoriteMeals[index].id,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
