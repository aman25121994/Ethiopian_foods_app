import 'package:ethiopian_foods_app/views/screens/detail/screens/search_product_screen.dart';
import 'package:flutter/material.dart';

class InnerHeaderWidget extends StatelessWidget {
  const InnerHeaderWidget({super.key});

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
              left: 13,
              top: 68,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
            Positioned(
              left: 60,
              top: 62,
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
