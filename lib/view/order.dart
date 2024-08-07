import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elec_e_comm/services/database.dart';
import 'package:elec_e_comm/services/shared_prefs.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Stream? orderStream;

  loadOrders() async {
    String? UserEmail = await SharedPreferencesHelper().getUserEmail();
    print(UserEmail);
    orderStream = await DatabaseMethods().getOrders(email: UserEmail);
    setState(() {});
  }

  Widget allOrders({required double height}) {
    return StreamBuilder(
      stream: orderStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  print(ds);

                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 14, right: 12, left: 12),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: height * 1 / 4,
                        child: Row(
                          children: [
                            Image.network(
                              ds["ProductImage"],
                              width: 200,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ds["Product"],
                                    style: AppWidget.boldTextFieldStyle(),
                                  ),
                                  Text(
                                    "₹" + ds["Price"],
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                          255,
                                          240,
                                          165,
                                          52,
                                        ),
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text("Status:" + ds["Status"],
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            240,
                                            165,
                                            52,
                                          ),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 235, 235),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Current Orders",
          style: AppWidget.TitleTextFieldStyle(),
        ),
      ),
      body: Container(child: allOrders(height: height)),
    );
  }
}
