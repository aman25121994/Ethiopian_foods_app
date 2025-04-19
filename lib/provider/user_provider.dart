import 'package:ethiopian_foods_app/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider()
      : super(User(
            id: '',
            fullName: '',
            email: '',
            state: '',
            city: '',
            locality: '',
            password: '',
            token: ''));

  User? get user => state;

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  void signOut() {
    state = null;
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
