import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Text("Car Rent Feb 2024"),
                      Text(
                        "5000",
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Balance",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13)),
                          Spacer(),
                          Text(
                            "525",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          )
                        ],
                      ),
                      Text("22 oct 4:51 PM",style: TextStyle(color: Colors.grey, fontSize: 13))
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
