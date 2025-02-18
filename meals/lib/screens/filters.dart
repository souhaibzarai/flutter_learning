import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilters = ref.watch(filtersProvider);
    var settingFilters = ref.read(filtersProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Filters',
        ),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: selectedFilters[Filter.glutenFree]!,
            title: const Text(
              'Gluten-free',
            ),
            subtitle: const Text(
              'only include meals with gluten',
            ),
            onChanged: (isActive) {
              settingFilters.setFilter(Filter.glutenFree, isActive);
            },
          ),
          SwitchListTile(
            value: selectedFilters[Filter.lactoseFree]!,
            title: const Text(
              'Lactose-free',
            ),
            subtitle: const Text(
              'only include meals with lactose',
            ),
            onChanged: (isActive) {
              settingFilters.setFilter(Filter.lactoseFree, isActive);
            },
          ),
          SwitchListTile(
            value: selectedFilters[Filter.vegetarian]!,
            title: const Text(
              'Vegetarian',
            ),
            subtitle: const Text(
              'only include veegtarian meals',
            ),
            onChanged: (isActive) {
              settingFilters.setFilter(Filter.vegetarian, isActive);
            },
          ),
          SwitchListTile(
            value: selectedFilters[Filter.vegan]!,
            title: const Text(
              'Vegan',
            ),
            subtitle: const Text(
              'only include vegan meals',
            ),
            onChanged: (isActive) {
              settingFilters.setFilter(Filter.vegan, isActive);
            },
          ),
        ],
      ),
    );
  }
}
