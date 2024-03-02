import 'package:expense_tracker/utils/appvalidator.dart';
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
  var isLoader = false;
  var appValidator = AppValidator();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      // var data = {
      //   "email": _emailController.text,
      //   "password": _passwordController.text,
      // };
      // await authService.login(data, context);

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
            validator: appValidator.isEmptyCheck,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextFormField(
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
              })
        ,
        SizedBox(height: 16,),
        ElevatedButton(onPressed: (){ 
          if (isLoader == false) {
                      _submitForm();
          }
        }, child: isLoader ? Center(child: CircularProgressIndicator()):
        
        Text("Add Transaction"))
        ],
      ),
      ),
    );
  }
}
