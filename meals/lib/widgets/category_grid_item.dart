import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.onSelectCategory,
    required this.category,
  });

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onSelectCategory,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(.58),
              category.color.withOpacity(.89),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          category.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
          ),
        ),
      ),
    );
  }
}
