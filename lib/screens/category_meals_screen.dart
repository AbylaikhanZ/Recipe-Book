import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String title;
  List<Meal> displayedMeals;
  var isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final String id = routeArgs["id"];
      title = routeArgs["title"];
      displayedMeals = widget.availableMeals.where(
        (meal) {
          return meal.categories.contains(id);
        },
      ).toList();
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealID) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              title: displayedMeals[index].title,
              imageURL: displayedMeals[index].imageUrl,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              duration: displayedMeals[index].duration,
              id: displayedMeals[index].id,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
