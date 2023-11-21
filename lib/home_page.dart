// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final Map<String, IconData> categoryIcons = {
//     'grocery': Icons.shopping_cart,
//     'fee': Icons.money,
//     'rent': Icons.home,
//     'dairy': Icons.emoji_food_beverage,
//     'internet': Icons.wifi,
//     'utilities': Icons.lightbulb,
//   };
//
//   Map<String, double> categorySums = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCategorySumsFromFirebase();
//   }
//
//   Future<void> _loadCategorySumsFromFirebase() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     QuerySnapshot transactionQuery =
//         await firestore.collection('transactions').get();
//
//     categorySums = {};
//
//     for (QueryDocumentSnapshot doc in transactionQuery.docs) {
//       final data = doc.data() as Map<String, dynamic>;
//       final amount = data['amount'] as double;
//       final category = data['category'] as String;
//
//       categorySums[category] = (categorySums[category] ?? 0) + amount;
//     }
//
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Personal Finance'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 250, // Adjust the height as needed
//             child: PieChart(
//               PieChartData(
//                 sections: categorySums.entries
//                     .map((entry) => PieChartSectionData(
//                           title: entry.key,
//                           value: entry.value,
//                           color: Colors.primaries[
//                               categorySums.keys.toList().indexOf(entry.key)],
//                         ))
//                     .toList(),
//                 borderData: FlBorderData(show: false),
//                 centerSpaceRadius: 40,
//                 sectionsSpace: 0,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//                 // Your budget section...
//                 ),
//           ),
//           Expanded(
//             flex: 2,
//             // child: Column(children: [
//             child: const Text(
//               "Summary",
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           SizedBox(height: 50.0),
//           Expanded(
//             flex: 2,
//             child: Column(
//               children: categorySums.keys.map((category) {
//                 return TransactionSummary(
//                   icon: categoryIcons[category] ?? Icons.error,
//                   type: category,
//                   value:
//                       "Rs ${categorySums[category]?.toStringAsFixed(2) ?? '0.00'}",
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.settings), label: 'Settings'),
//         ],
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               Navigator.pushNamed(context, '/home_page');
//               break;
//             case 1:
//               Navigator.pushNamed(context, '/transactions_history');
//               break;
//             case 2:
//               Navigator.pushNamed(context, '/transactions_input');
//               break;
//           }
//         },
//       ),
//     );
//   }
// }
//
// class TransactionSummary extends StatelessWidget {
//   TransactionSummary({this.icon, this.type, this.value});
//   final IconData? icon;
//   final String? type;
//   final String? value;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10.0),
//       margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0), color: Colors.white),
//       child: Row(
//         children: [
//           Expanded(
//             child: Icon(
//               icon,
//               color: Colors.black38,
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               type!,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20.0,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value!,
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 20.0,
//                   fontFamily: 'Roboto'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final Map<String, IconData> categoryIcons = {
  //   'grocery': Icons.shopping_cart,
  //   'fee': Icons.money,
  //   'rent': Icons.home,
  //   'dairy': Icons.emoji_food_beverage,
  //   'internet': Icons.wifi,
  //   'utilities': Icons.lightbulb,
  // };

  Map<String, double> categorySums = {};

  @override
  void initState() {
    super.initState();
    _loadCategorySumsFromFirebase();
  }

  Future<void> _loadCategorySumsFromFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot transactionQuery =
        await firestore.collection('transactions').get();

    categorySums = {};

    for (QueryDocumentSnapshot doc in transactionQuery.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final amount = data['amount'] as double;
      final category = data['category'] as String;

      categorySums[category] = (categorySums[category] ?? 0) + amount;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Personal Finance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: PieChart(
                PieChartData(
                  sections: categorySums.entries
                      .map((entry) => PieChartSectionData(
                            title: entry.key,
                            value: entry.value,
                            radius: 110,
                            color: Colors.primaries[
                                categorySums.keys.toList().indexOf(entry.key)],
                          ))
                      .toList(),
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 40,
                  sectionsSpace: 0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: categorySums.keys.map((category) {
                  return TransactionSummary(
                    // icon: categoryIcons[category] ?? Icons.error,
                    type: category,
                    value:
                        "Rs ${categorySums[category]?.toStringAsFixed(2) ?? '0.00'}",
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home_page');
              break;
            case 1:
              Navigator.pushNamed(context, '/transactions_history');
              break;
            case 2:
              Navigator.pushNamed(context, '/transactions_input');
              break;
          }
        },
      ),
    );
  }
}

class TransactionSummary extends StatelessWidget {
  TransactionSummary({this.icon, this.type, this.value});
  final IconData? icon;
  final String? type;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.white),
      child: Row(
        children: [
          // Expanded(
          //   child: Icon(
          //     icon,
          //     color: Colors.black38,
          //   ),
          // ),
          Expanded(
            flex: 2,
            child: Text(
              type!,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value!,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  fontFamily: 'Roboto'),
            ),
          ),
        ],
      ),
    );
  }
}
