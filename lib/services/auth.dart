import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future SignOut() async {
    await auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future deleteUser() async {
    User? user = await FirebaseAuth.instance.currentUser;
    print(user);
    user?.delete();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
