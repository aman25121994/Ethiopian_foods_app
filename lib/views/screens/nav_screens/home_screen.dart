import 'package:ethiopian_foods_app/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/widgets/category_item_widget.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/widgets/popular_product_widget.dart';
import 'package:ethiopian_foods_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
            child: const HeaderWidget()),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              BannerWidget(),
              CategoryItemWidget(),
              ReusableTextWidget(
                title: 'Popular Foods',
                subtitle: '',
              ),
              PopularProductWidget(),
            ],
          ),
        ));
  }
}
