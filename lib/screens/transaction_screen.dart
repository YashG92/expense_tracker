import 'package:expense_tracker/widgets/category_list.dart';
import 'package:expense_tracker/widgets/tab_bar_view.dart';
import 'package:expense_tracker/widgets/time_line_month.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
   String category = '';
    String monthYear = '';
  @override
  Widget build(BuildContext context) {

   

    return Scaffold(
      appBar: AppBar(title: Text('Expenses'),),
      body: Column(
        children: [
          TimeLineMonth(onChanged: (String? value) { 
           if (value!=null) {
             setState((){
              monthYear = value;
             });
           }
           },),
          CategoryList(onChanged: (String? value) { 
            if (value!=null) {
              setState(() {
                category = value;
              });
            }
           },),
           MyTabBarView(category: category, monthYear: monthYear,),
        ],
      ),
    );
  }
}
