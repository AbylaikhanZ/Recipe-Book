import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";

  final Map<String, bool> filters;
  final Function saveFilters;
  final Function resetFilters;
  FiltersScreen(this.filters, this.saveFilters, this.resetFilters);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile.adaptive(
      activeColor: Theme.of(context).colorScheme.primary,
      title: Text(title),
      value: currentValue,
      onChanged: updateValue,
      subtitle: Text(description),
    );
  }

  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  @override
  void initState() {
    _glutenFree = widget.filters["gluten"];
    _lactoseFree = widget.filters["lactose"];
    _vegan = widget.filters["vegan"];
    _vegetarian = widget.filters["vegetarian"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your filters"),
      ),
      drawer: MainDrawer(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "Adjust your meal preferences",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            buildSwitchListTile(
                "Gluten-free", "Only include gluten-free meals", _glutenFree,
                (newValue) {
              setState(() {
                _glutenFree = newValue;
              });
            }),
            buildSwitchListTile(
                "Vegetarian", "Only include vegetarian meals", _vegetarian,
                (newValue) {
              setState(() {
                _vegetarian = newValue;
              });
            }),
            buildSwitchListTile(
                "Lactose-free", "Only include lactose-free meals", _lactoseFree,
                (newValue) {
              setState(() {
                _lactoseFree = newValue;
              });
            }),
            buildSwitchListTile("Vegan", "Only include vegan meals", _vegan,
                (newValue) {
              setState(() {
                _vegan = newValue;
              });
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      final selectedFilters = {
                        "gluten": _glutenFree,
                        "lactose": _lactoseFree,
                        "vegan": _vegan,
                        "vegetarian": _vegetarian,
                      };
                      widget.saveFilters(selectedFilters);
                    },
                    icon: Icon(Icons.save)),
                IconButton(
                    onPressed: widget.resetFilters,
                    icon: Icon(Icons.restart_alt_rounded))
              ],
            )
          ],
        ))
      ]),
    );
  }
}
