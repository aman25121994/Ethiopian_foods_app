import 'dart:convert';

import 'package:ethiopian_foods_app/global_variables.dart';
import 'package:ethiopian_foods_app/models/user.dart';
import 'package:ethiopian_foods_app/provider/user_provider.dart';
import 'package:ethiopian_foods_app/services/manage_http_response.dart';
import 'package:ethiopian_foods_app/views/screens/authentication_screens/login_screen.dart';
import 'package:ethiopian_foods_app/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user
              .toJson(), //Convert the user object to Json for the request body
          headers: <String, String>{
            //Set the headers for the request
            "Content-Type":
                "application/json; charset=UTF-8", // specify the cntent type as json
          });

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          showSnackBar(context, 'Account has been created for you');
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  //signin user function
  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode(
            {
              'email': email, //include the email and request body
              'password': password,
            },
          ),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      //handle response using the managehttpresponse
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            String token = jsonDecode(response.body)['token'];

            await preferences.setString('auth_token', token);

            final userJson = jsonEncode(jsonDecode(response.body)['user']);

            providerContainer.read(userProvider.notifier).setUser(userJson);

            await preferences.setString('user', userJson);

            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return MainScreen();
            }), //add const later
                (route) => false);
            showSnackBar(context, 'Logged In');
          });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> signOutUser({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      await preferences.remove('auth_token');
      await preferences.remove('user');
      providerContainer.read(userProvider.notifier).signOut();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }), (route) => false);

      showSnackBar(context, 'signned out successfully');
    } catch (e) {
      showSnackBar(context, 'error signing out');
    }
  }
}
