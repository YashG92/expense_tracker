import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/utils/appvalidator.dart';
import 'package:expense_tracker/widgets/category_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../screens/upi.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  var type = "credit";
  var categoty = "Others";
  var isLoader = false;
  var appValidator = AppValidator();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var amountEditController = TextEditingController();
  var titleEditController = TextEditingController();
  var upiIdController = TextEditingController();
  var uid = Uuid();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      final user = FirebaseAuth.instance.currentUser;
      int timestamp = DateTime.now().microsecondsSinceEpoch;
      var amount = int.parse(amountEditController.text);
      DateTime date = DateTime.now();

      var id = uid.v4();
      String monthyear = DateFormat('MMM y').format(date);

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      int remainingAmount = userDoc['remainingAmount'];
      int totalCredit = userDoc['totalCredit'];
      int totalDebit = userDoc['totalDebit'];

      if (type == 'credit') {
        remainingAmount += amount;
        totalCredit += amount;
      } else {
        remainingAmount -= amount;
        totalDebit -= amount;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        "remainingAmount": remainingAmount,
        "totalCredit": totalCredit,
        "totalDebit": totalDebit,
        "updatedAt": timestamp
      });

      var data = {
        "id": id,
        "title": titleEditController.text,
        "amount": amount,
        "type": type,
        "timestamp": timestamp,
        "totalDebit": totalDebit,
        "totalCredit": totalCredit,
        "remainingAmount": remainingAmount,
        "monthyear": monthyear,
        "category": categoty,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("transactions")
          .doc(id)
          .set(data);

      // await authService.login(data, context);

      Navigator.pop(context);

      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleEditController,
              validator: appValidator.isEmptyCheck,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextFormField(
              controller: upiIdController,
              //validator: appValidator.isEmptyCheck,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Upi id',
              ),
            ),
            TextFormField(
              controller: amountEditController,
              validator: appValidator.isEmptyCheck,
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
                }),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (isLoader == false) {
                    _submitForm();
                  }
                },
                child: isLoader
                    ? Center(child: CircularProgressIndicator())
                    : Text("Add Transaction")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pay(
                          upiID: upiIdController.text,
                          amount: double.parse(amountEditController.text),
                        ),
                      )).then((_)=> _submitForm());
                },
                child: Text("UPI"))
          ],
        ),
      ),
    );
  }
}
