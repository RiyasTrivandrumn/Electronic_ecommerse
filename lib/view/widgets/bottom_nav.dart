import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elec_e_comm/view/home.dart';
import 'package:elec_e_comm/view/order.dart';
import 'package:elec_e_comm/view/profile.dart';

import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;
  late HomePage homepage;
  late Order order;
  late Profile profile;
  int currentTabIndex = 0;
  @override
  void initState() {
    homepage = HomePage();
    order = Order();
    profile = Profile();
    pages = [homepage, order, profile];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          onTap: (index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          height: 50,
          backgroundColor: Color.fromARGB(255, 239, 235, 235),
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500),
          items: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outlined,
              color: Colors.white,
            ),
          ]),
      body: pages[currentTabIndex],
    );
  }
}
