import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onToggle,
  });

  final void Function(String identifier) onToggle;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(.55),
                  Theme.of(context).colorScheme.primary.withOpacity(.23),
                  Theme.of(context).colorScheme.primary.withOpacity(.82),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.fastfood_outlined,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 35,
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 15,
                  ),
            ),
            leading: Icon(
              Icons.set_meal_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onTap: () {
              onToggle('meals');
            },
          ),
          ListTile(
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 15,
                  ),
            ),
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onTap: () {
              onToggle('filters');
            },
          ),
        ],
      ),
    );
  }
}
