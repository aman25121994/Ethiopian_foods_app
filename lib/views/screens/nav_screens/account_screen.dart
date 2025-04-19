import 'package:ethiopian_foods_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AuthController _authController = AuthController();

  void showSignOutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Are you sure',
              style: GoogleFonts.montserrat(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Do you really want to logout?',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await _authController.signOutUser(context: context);
                },
                child: Text(
                  'Logout',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            showSignOutDialog(context);
          },
          child: Text('SignOut')),
    );
  }
}
