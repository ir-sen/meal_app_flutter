import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/filter_provider.dart';
import 'package:meal_app/providers/meals_provider.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {

  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {

    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) =>  m.id != meal.id).toList();
      return false; 
    } else {
      // copy odl list and add new list
      state = [...state, meal];
      return true;
    }

  }

}

// just provider greate use if you have static provider class
final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>( (ref) {
  return FavoriteMealsNotifier();
} ); 

final filterdMealsProvider = Provider((ref) {

  // this provider depends other providers
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

    return meals.where((meal) {
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
});