// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() {
    return _GroceryListState();
  }
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  String? texterror = 'Deleted Successfully';
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
      'flutter-shopping-e3f8f-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      setState(() {
        error = 'Failed to fetch data. try again later.';
        isLoading = false;
      });
    }

    if (response.body == 'null') {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final Map<String, dynamic> listData = json.decode(response.body);

    final List<GroceryItem> _loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries.firstWhere((catItem) {
        return catItem.value.title == item.value['category'];
      }).value;

      _loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }

    setState(() {
      isLoading = false;
      _groceryItems = _loadedItems;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) {
          return NewItem();
        },
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _onRemove(GroceryItem grocery) async {
    final currentIndex = _groceryItems.indexOf(grocery);

    setState(() {
      _groceryItems.remove(grocery);
    });

    final url = Uri.https(
      'flutter-shopping-e3f8f-default-rtdb.firebaseio.com',
      'shopping-list/${grocery.id}.json',
    );

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        texterror = 'Failed to delete!';
        _groceryItems.insert(currentIndex, grocery);
      });
    }

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texterror!),
      ),
    );
  }

  @override
  Widget build(context) {
    final grocery = _groceryItems;

    late Widget content = Center(
      child: Text('You got nothing yet!'),
    );

    if (error != null) {
      content = Center(
        child: Text(error!),
      );
    }

    if (isLoading) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(_groceryItems[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(.53),
            ),
            onDismissed: (direction) {
              _onRemove(_groceryItems[index]);
            },
            child: ListTile(
              title: Text(grocery[index].name),
              leading: Container(
                width: 30,
                height: 30,
                color: grocery[index].category.color,
              ),
              trailing: Text(
                '${grocery[index].quantity}',
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries!'),
        actions: [
          IconButton(
            onPressed: error != null ? null : _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
