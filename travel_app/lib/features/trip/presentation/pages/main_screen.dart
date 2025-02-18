import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/features/trip/presentation/pages/add_trip_screen.dart';
import 'package:travel_app/features/trip/presentation/pages/my_trips_screen.dart';
import 'package:travel_app/features/trip/presentation/widgets/map_introcude.dart';

class MainScreen extends ConsumerWidget {
  MainScreen({super.key});

  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _pageController.addListener(() {
      _currentPage.value = _pageController.page!.round();
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 100,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi User! 👋🏻',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Travelling Today?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-photo/lifestyle-people-emotions-casual-concept-confident-nice-smiling-asian-woman-cross-arms-chest-confident-ready-help-listening-coworkers-taking-part-conversation_1258-59335.jpg'),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          MyTripsScreen(),
          AddTripScreen(),
          MapIntrocude(),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _currentPage,
        builder: (context, pageIndex, child) {
          return BottomNavigationBar(
            selectedItemColor: Color.fromARGB(200, 129, 112, 196),
            currentIndex: pageIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'My Trips',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add Trip',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Maps',
              ),
            ],
            onTap: (index) {
              _pageController.jumpToPage(index);
            },
          );
        },
      ),
    );
  }
}
