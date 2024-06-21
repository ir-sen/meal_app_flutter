import 'package:flutter_riverpod/flutter_riverpod.dart';


enum Filter {
  glutternFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNorifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNorifier() : super({
    Filter.glutternFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive;
    state = {
      ...state,
      filter: isActive,
    };
  }


}

final filtersProvider = StateNotifierProvider<FiltersNorifier, Map<Filter, bool>>(
  (ref) => FiltersNorifier(),
  );

