import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';


class CategoriesSreen extends StatelessWidget {

  const CategoriesSreen({super.key});

  void _selectCategory(BuildContext context)  {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: "come title",
        meals: []),
      )); // or Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category '),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          ),
        children: [
          // availableCategories.map((category) => )
          for (final category in availableCategories) 
            CategoryGridItem(category: category, onSelectCategory: () {
              _selectCategory(context);
            },)
            
        ],
      )
    );
  }

}