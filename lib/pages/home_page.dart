import 'package:flutter/material.dart';
import 'package:test_app/pages/home_test_page.dart';
import 'package:test_app/pages/posts_page.dart';
import 'package:test_app/pages/users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _tabList = [
    const PostsPage(),
    const UsersPage(),
    const HomeTestPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
                backgroundColor: Colors.black,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                onTap: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                currentIndex: _currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.local_post_office), label: 'Posts'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Users'),
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home')
                ]),
          ),
        ),
        body: _tabList.elementAt(_currentIndex));
  }
}
