import 'package:elec_e_comm/admin/add_products.dart';
import 'package:elec_e_comm/admin/allorders.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 235, 235),
      appBar: AppBar(
        title: Text(
          "Home Admin",
          style: AppWidget.boldTextFieldStyle(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProdut(),
                  ));
            },
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 15),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add Products",
                          style: AppWidget.SemiBoldTextStyle(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllOrders(),
                  ));
            },
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 15),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "All Orders",
                          style: AppWidget.SemiBoldTextStyle(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
