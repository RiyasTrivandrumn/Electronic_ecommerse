import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elec_e_comm/services/database.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';
import 'package:flutter/material.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  Stream? allStream;

  loadProducts() async {
    allStream = await DatabaseMethods().allOrders();
    setState(() {});
  }

  Widget allOrders({required double height}) {
    return StreamBuilder(
      stream: allStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];

                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 14, right: 12, left: 12),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: height * 1.7 / 5,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(ds["image"]),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 13, right: 13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Name:" + ds["name"],
                                      style: AppWidget.boldTextFieldStyle(),
                                    ),
                                    Text(
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      "Email:" + ds["email"],
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 153, 150, 150),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(ds["Product"],
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              240,
                                              165,
                                              52,
                                            ),
                                            fontSize: 23,
                                            fontWeight: FontWeight.w500)),
                                    Text("₹" + ds["Price"],
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 23,
                                            fontWeight: FontWeight.w500)),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 15),
                                            backgroundColor: Colors.cyan),
                                        onPressed: () {
                                          DatabaseMethods()
                                              .updateOrder(DocId: ds.id);
                                          setState(() {});
                                        },
                                        child: Text(
                                          "Done",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ))
                                  ],
                                ),
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
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 235, 235),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "All Orders",
          style: AppWidget.TitleTextFieldStyle(),
        ),
      ),
      body: Container(
        child: allOrders(height: height),
      ),
    );
  }
}
