import 'package:flutter/material.dart';

import '../../detail/screens/search_product_screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.20,
        child: Stack(
          children: [
            Image.asset(
              'assets/icons/searchBanner.jpeg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 48,
              top: 60,
              child: SizedBox(
                width: 250,
                height: 50,
                child: TextField(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SearchProductScreen();
                    }));
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Text',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7F7F7F),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    prefixIcon: Image.asset(
                      "assets/icons/searc1.png",
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    focusColor: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
