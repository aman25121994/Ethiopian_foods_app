import 'package:ethiopian_foods_app/models/category.dart';
import 'package:ethiopian_foods_app/views/screens/detail/screens/widgets/inner_category_content_widget.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/account_screen.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/ai_screen.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/category_screen.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/favorite_screen.dart';
import 'package:flutter/material.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      InnerCategoryContentWidget(
        category: widget.category,
      ),
      const FavoriteScreen(),
      const CategoryScreen(),
      const AiScreen(),
      AccountScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/home.png",
                width: 25,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/love.png",
                width: 25,
              ),
              label: "Favorite"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/camera.png",
                width: 25,
              ),
              label: "AI"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/user.png",
                width: 25,
              ),
              label: "Account"),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
