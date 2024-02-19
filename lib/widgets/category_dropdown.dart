import 'package:expense_tracker/utils/icons_list.dart';
import 'package:flutter/material.dart';

class CategoryDropDown extends StatelessWidget {
  CategoryDropDown({Key? key, this.cattype, required this.onChanged}) : super(key: key);
  final String? cattype;
  final ValueChanged<String?> onChanged;

  var appIcons = AppIcons();

  @override
  Widget build(BuildContext context) {
    bool isCatTypeValid = cattype != null &&
        appIcons.homeExpensesCategories.any((element) => element['name'] == cattype);

    return DropdownButton<String>(
      value: isCatTypeValid ? cattype : null,
      isExpanded: true,
      hint: Text("Select Category"),
      items: appIcons.homeExpensesCategories
          .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
        value: e['name'],
        child: Row(
          children: [
            Icon(
              e['icon'],
              color: Colors.black54,
            ),
            SizedBox(width: 10,),
            Text(
              e['name'],
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
