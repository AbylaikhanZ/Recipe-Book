import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/dummy_data.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'package:flutter_complete_guide/screens/filters_screen.dart';
import 'package:flutter_complete_guide/screens/meal_detail_screen.dart';
import 'package:flutter_complete_guide/screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "lactose": false,
    "gluten": false,
    "vegan": false,
    "vegetarian": false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> newFilters) {
    setState(() {
      print(newFilters["gluten"]);
      print(newFilters["vegetarian"]);
      print(newFilters["vegan"]);
      print(newFilters["lactose"]);

      _filters = newFilters;
      _availableMeals = DUMMY_MEALS.where((element) {
        if (!element.isLactoseFree && _filters["lactose"]) return false;
        if (!element.isVegan && _filters["vegan"]) return false;
        if (!element.isVegetarian && _filters["vegetarian"]) return false;
        if (!element.isGlutenFree && _filters["gluten"]) return false;
        return true;
      }).toList();
    });
  }

  void _resetFilters() {
    setState(() {
      _filters["gluten"] = false;
      _filters["lactose"] = false;
      _filters["vegan"] = false;
      _filters["vegetarian"] = false;
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          canvasColor: Color.fromARGB(255, 254, 248, 193),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
              .copyWith(secondary: Colors.red),
          fontFamily: "Montserrat",
          textTheme: ThemeData.light().textTheme.copyWith(
                //bodyText1: TextStyle(color: Color.fromARGB(215, 48, 247, 3)),
                //bodyText2: TextStyle(color: Color.fromARGB(226, 255, 191, 0)),
                titleMedium: TextStyle(
                    fontSize: 20,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold),
                titleLarge: TextStyle(fontSize: 24, fontFamily: "Roboto"),
              )),
      routes: {
        "/": (context) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, isFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters, _resetFilters)
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      body: Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}
