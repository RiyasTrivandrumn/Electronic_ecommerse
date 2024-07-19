import 'package:elec_e_comm/view/widgets/support_widget.dart';

import 'package:flutter/material.dart';

class AllProductsTile extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  const AllProductsTile(
      {super.key,
      required this.image,
      required this.title,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            image,
            height: 120,
            width: 140,
          ),
          Text(
            title,
            style: AppWidget.SemiBoldTextStyle(),
          ),
          Row(
            children: [
              Text(
                "\$$price",
                style: TextStyle(
                    color: const Color.fromARGB(255, 208, 142, 41),
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 35,
              ),
              Container(
                  color: Colors.orange,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
