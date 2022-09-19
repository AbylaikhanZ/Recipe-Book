import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/meal-detail";
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
      margin: EdgeInsets.symmetric(vertical: 10),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey)),
      height: 250,
      width: 350,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealID = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealID);
    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(ListView.builder(
              padding: EdgeInsets.all(10),
              itemBuilder: ((context, index) => Card(
                    margin: EdgeInsets.all(2),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                      child: Text(
                        selectedMeal.ingredients[index],
                      ),
                    ),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  )),
              itemCount: selectedMeal.ingredients.length,
            )),
            buildSectionTitle(context, "Steps"),
            buildContainer(ListView.builder(
              itemBuilder: ((context, index) => Column(children: [
                    ListTile(
                      leading: CircleAvatar(
                          child: Text("# ${index + 1}"),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
                          foregroundColor: Colors.black),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(),
                  ])),
              itemCount: selectedMeal.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.of(context).pop(mealID);
        },
      ),
    );
  }
}
