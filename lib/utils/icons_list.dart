import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcons {
  final List<Map<String, dynamic>> homeExpensesCategories = [
    { "name": "Fuel Filling",
      "icon": FontAwesomeIcons.gasPump,
    },
    {"name": "Groceries", "icon": FontAwesomeIcons.basketShopping},
    {"name": "Dining Out", "icon": FontAwesomeIcons.utensils},
    {"name": "Utilities", "icon": FontAwesomeIcons.water},
    {"name": "Rent", "icon": FontAwesomeIcons.house},
    {"name": "Transportation", "icon": FontAwesomeIcons.bus},
    {"name": "Entertainment", "icon": FontAwesomeIcons.film},
    {"name": "Healthcare", "icon": FontAwesomeIcons.suitcaseMedical},
    {"name": "Education", "icon": FontAwesomeIcons.graduationCap},
    {"name": "Clothing", "icon": FontAwesomeIcons.shirt},
    {"name": "Travel", "icon": FontAwesomeIcons.plane},
    {"name": "Gifts", "icon": FontAwesomeIcons.gift},
    {"name": "Insurance", "icon": FontAwesomeIcons.shieldHalved},
    {"name": "Investments", "icon": FontAwesomeIcons.chartLine},
    {"name": "Taxes", "icon": FontAwesomeIcons.fileInvoice},
    {"name": "Pets", "icon": FontAwesomeIcons.dog},
    {"name": "Home Repairs", "icon": FontAwesomeIcons.screwdriverWrench},
    {"name": "Charity", "icon": FontAwesomeIcons.handshakeAngle},
    {"name": "Miscellaneous", "icon": FontAwesomeIcons.circleQuestion},
  ];

  IconData getExpenseCategoryIcons(String categoryName) {
    final category = homeExpensesCategories.firstWhere(
        (category) => category['name'] == categoryName,
        orElse: () => {"icon": FontAwesomeIcons.cartShopping});
    return category['icon'];
  }
}
