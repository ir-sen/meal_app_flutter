import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';

class CategoriesSreen extends StatefulWidget {
  const CategoriesSreen({
    super.key,
    required this.avalibleMeals,
  });

  final List<Meal> avalibleMeals;

  @override
  State<CategoriesSreen> createState() => _CategoriesSreenState();
}

class _CategoriesSreenState extends State<CategoriesSreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 230000),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  // this is function for open nex screen
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.avalibleMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    ); // or Navigator.push(context, route)
  }

  // create animation 
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
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
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(
                      context, category); // here is init this function
                },
              )
          ],
        ),
        builder: (context, child) => SlideTransition(
              position: Tween (
                begin: const Offset(0, 0.3),
                end: const Offset(0 ,0),
              ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),),
              child: child,
            ));
  }
}
