import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

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