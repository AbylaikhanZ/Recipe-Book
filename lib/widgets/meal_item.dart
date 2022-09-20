import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'package:flutter_complete_guide/screens/meal_detail_screen.dart';
import 'package:flutter_complete_guide/widgets/duration_complexity_bar.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageURL,
    @required this.affordability,
    @required this.complexity,
    @required this.duration,
  });

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetailScreen.routeName, arguments: id)
        .then((result) {
      if (result != null) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(10),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(imageURL,
                      height: 250, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 20,
                  child: Container(
                    width: 350,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black54,
                      backgroundBlendMode: BlendMode.darken,
                    ),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: DurationComplexityBar(
                  affordability: affordability,
                  complexity: complexity,
                  duration: duration),
            ),
          ],
        ),
      ),
    );
  }
}
