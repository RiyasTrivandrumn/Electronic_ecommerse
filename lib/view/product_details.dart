import 'package:elec_e_comm/view/widgets/support_widget.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  String name, price, details, image;
  ProductDetails(
      {super.key,
      required this.name,
      required this.image,
      required this.price,
      required this.details});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 235, 235),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  GestureDetector(
                    onTap: () {
                      print("1");
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5, left: 20),
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.arrow_back_ios_new_outlined),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  Center(
                    child: Image.network(
                      widget.image,
                      height: 400,
                    ),
                  )
                ]),
                Container(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 35),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.name,
                              style: AppWidget.boldTextFieldStyle(),
                            ),
                            Text(
                              "\$${widget.price}",
                              style: TextStyle(
                                  color: Color.fromARGB(
                                    255,
                                    240,
                                    165,
                                    52,
                                  ),
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Details",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.details,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 90,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(child: Text("Buy Now")),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
