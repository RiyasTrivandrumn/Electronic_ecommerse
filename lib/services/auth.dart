import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future SignOut() async {
    await auth.signOut();
  }

  Future deleteUser() async {
    User? user = await FirebaseAuth.instance.currentUser;
    print(user);
    user?.delete();
  }
}
