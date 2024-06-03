import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/widgets/category_grid_item.dart';


class CategoriesCreen extends StatelessWidget {

  const CategoriesCreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            CategoryGridItem(category: category)
            
        ],
      )
    );
  }

}