import 'package:elec_e_comm/services/shared_prefs.dart';
import 'package:elec_e_comm/view/home.dart';
import 'package:elec_e_comm/view/login.dart';
import 'package:elec_e_comm/view/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 3), () {
      UserLoggedIn();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  void UserLoggedIn() async {
    String? Userid = await SharedPreferencesHelper().getUserEmail();
    if (Userid != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(),
          ));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 85, 153, 184),
            Color.fromARGB(255, 22, 17, 17)
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 2,
            ),
            Image.asset(
              "assets/Electromart (2).png",
              height: 300,
              width: 300,
            ),
          ],
        )),
      ),
    );
  }
}
