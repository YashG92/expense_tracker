import 'package:expense_tracker/widgets/category_dropdown.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  var type = "credit";
  var categoty = "Others";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
          ),
          CategoryDropDown(
            cattype: categoty,
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  categoty = value;
                });
              }
            },
          ),
          DropdownButtonFormField(
              value: 'credit',
              items: [
                DropdownMenuItem(
                  child: Text('Credit'),
                  value: 'credit',
                ),
                DropdownMenuItem(
                  child: Text('Debit'),
                  value: 'debit',
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    type = value;
                  });
                }
              })
        ],
      )),
    );
  }
}
