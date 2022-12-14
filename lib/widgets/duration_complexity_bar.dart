import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'meal_item.dart';

class DurationComplexityBar extends StatelessWidget {
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  DurationComplexityBar({this.duration, this.complexity, this.affordability});

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return "Simple";
        break;
      case Complexity.Challenging:
        return "Challenging";
        break;
      case Complexity.Hard:
        return "Hard";
        break;
      default:
        return "Unknown";
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return "Affordable";
        break;
      case Affordability.Pricey:
        return "Pricey";
        break;
      case Affordability.Luxurious:
        return "Expensive";
        break;
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
              ),
              SizedBox(
                width: 6,
              ),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child:
                      Text("$duration min ", style: TextStyle(fontSize: 20))),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.work,
              ),
              SizedBox(
                width: 6,
              ),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("$complexityText ",
                      style: TextStyle(fontFamily: "Roboto", fontSize: 18))),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.attach_money,
              ),
              SizedBox(
                width: 6,
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("$affordabilityText ",
                    style: TextStyle(fontFamily: "Roboto", fontSize: 18)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
