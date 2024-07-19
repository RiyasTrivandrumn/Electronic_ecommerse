import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elec_e_comm/services/database.dart';
import 'package:elec_e_comm/view/product_details.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';

import 'package:flutter/material.dart';

class ProductCatogory extends StatefulWidget {
  String catogory;
  ProductCatogory({required this.catogory});

  @override
  State<ProductCatogory> createState() => _ProductCatogoryState();
}

class _ProductCatogoryState extends State<ProductCatogory> {
  Stream? CatogoryStream;

  getontheload() async {
    CatogoryStream = await DatabaseMethods().getProducts(widget.catogory);
    setState(() {});
  }

  Widget allProducts() {
    return StreamBuilder(
      stream: CatogoryStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                    mainAxisSpacing: 10.0),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];

                  return Container(
                    margin: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.network(
                            ds["Image"],
                            height: 120,
                            width: 140,
                          ),
                          Text(
                            ds["Name"],
                            style: AppWidget.SemiBoldTextStyle(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "\$" + ds["Price"],
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 208, 142, 41),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                            name: ds["Name"],
                                            image: ds["Image"],
                                            price: ds["Price"],
                                            details: ds["Details"]),
                                      ));
                                },
                                child: Container(
                                    color: Colors.orange,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getontheload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 235, 235),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Color.fromARGB(255, 239, 235, 235),
      ),
      body: Container(
        child: Column(
          children: [Expanded(child: allProducts())],
        ),
      ),
    );
  }
}
