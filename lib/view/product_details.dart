import 'dart:convert';

import 'package:elec_e_comm/services/constant.dart';
import 'package:elec_e_comm/services/database.dart';
import 'package:elec_e_comm/services/shared_prefs.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

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
  String? name, mail, image;

  getthesharedprefs() async {
    name = await SharedPreferencesHelper().getUserName();
    mail = await SharedPreferencesHelper().getUserEmail();
    image = await SharedPreferencesHelper().getUserImage();
    setState(() {});
  }

  Map<String, dynamic>? paymentIntent;

  @override
  void initState() {
    // TODO: implement initState
    getthesharedprefs();
  }

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
                      print(1);
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
                        GestureDetector(
                          onTap: () {
                            makePayment(widget.price);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Text("Buy Now")),
                          ),
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

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      print(paymentIntent);

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent?['client_secret'],
                  style: ThemeMode.system,
                  merchantDisplayName: 'Riyas'))
          .then((Value) {});

      displayPaymentSheet();
    } catch (e, s) {
      print('exception: $e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        Map<String, dynamic> orderInfomap = {
          "Product": widget.name,
          "Price": widget.price,
          "name": name,
          "email": mail,
          "image": image,
          "ProductImage": widget.image,
          "Status": "On the way"
        };

        await DatabaseMethods().orderDetails(orderInfomap);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                Text("Payment Successfull")
              ],
            ),
          ),
        );
        paymentIntent = null;
      }).onError((error, StackTrace) {
        print("Error is:---> $error $StackTrace");
      });
    } on StripeException catch (e) {
      print("Error is :$e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Cancelled"),
        ),
      );
    } catch (e) {
      print("Error charging user:${e.toString()}");
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": 'card'
      };
      Uri url = Uri.parse("https://api.stripe.com/v1/payment_intents");
      var response = await http.post(url,
          headers: {
            'Authorization': "Bearer $secretkey",
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: body);
      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      print("error charging user: ${e.toString()}");
      return null;
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount) * 100).toInt();
    return calculatedAmount.toString();
  }
}
