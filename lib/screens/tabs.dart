import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/filter_provider.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/providers/meals_provider.dart';
import 'package:meal_app/providers/favatites_provider.dart'; 


const kInitialFilters = {
    Filter.glutternFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }

}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // create this list for save fovorites
  final List<Meal> _favoriteMeals = [];




  // // function for save favorite
  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal is no longer a favorite');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('Marked as a favorite');
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
  // save every state in screen 
  void _setScreen(String indentifier) async {
    Navigator.of(context).pop();
    if (indentifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );  
      
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals =  meals.where((meal) {
      if (activeFilters[Filter.glutternFree]! && !meal.isGlutenFree){
        return false;
      }

      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }

      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }

      if (activeFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      
      return true;

    }).toList();

    // triger for function invoke
    Widget activePage = CategoriesSreen(
      avalibleMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activePage = MealsScreen(
        meals: _favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      // this is left slide menu
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),

      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
