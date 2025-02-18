import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

import 'package:meals/providers/favorite_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _currentPageIndex = 0;

  void onSelectTab(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );

    var currentPageTitle = 'Categories';
    if (_currentPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        meals: favoriteMeals,
        text: 'List of Favorite is Empty!',
      );
      currentPageTitle = 'Favorite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentPageTitle,
        ),
      ),
      drawer: MainDrawer(
        onToggle: _setScreen,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.set_meal,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorite',
          ),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
