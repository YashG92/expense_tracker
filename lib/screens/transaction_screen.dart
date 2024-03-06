import 'package:expense_tracker/widgets/time_line_month.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expenses'),),
      body: Column(
        children: [
          TimeLineMonth(),
        ],
      ),
    );
  }
}
