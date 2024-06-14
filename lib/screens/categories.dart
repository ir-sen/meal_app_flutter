import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';


class CategoriesSreen extends StatelessWidget {

  const CategoriesSreen({
    super.key,
    required this.onToggleFavorite,
    required this.avalibleMeals,
    });

  final void Function(Meal meal) onToggleFavorite;

  final List<Meal> avalibleMeals;
  
  // this is function for open nex screen
  void _selectCategory(BuildContext context, Category category)  {

    final filteredMeals = avalibleMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList(); 

    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: category.title,
        meals: filteredMeals,
        onToggleFavorite: onToggleFavorite,
        ),
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
          // init here for open nex display
            CategoryGridItem(category: category, onSelectCategory: () {
              _selectCategory(context, category); // here is init this function 
            },)
            
        ],
      )
    );
  }

}