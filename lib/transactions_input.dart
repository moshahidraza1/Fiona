import 'package:flutter/material.dart';
import 'transactions_history.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionInput extends StatefulWidget {
  // final Function(String, double) addTransaction;

  // TransactionInput(this.addTransaction);

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String selectedTransactionType = 'Grocery';

  void _submitData() async {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    final category = selectedTransactionType;
    if (selectedTransactionType.isEmpty || enteredAmount <= 0) {
      return;
    }

    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Add the transaction data to a 'transactions' collection
      await firestore.collection('transactions').add({
        // 'name': FirebaseAuth.instance.currentUser!.displayName,
        'title': enteredTitle,
        'amount': enteredAmount,
        'category': category,
      });
      Navigator.pop(context, {
        'title': enteredTitle,
        'amount': enteredAmount,
        'category': category,
      });
      // widget.addTransaction(selectedTransactionType, enteredAmount);

      // Clear input fields after successfully adding to Firestore
      titleController.clear();
      amountController.clear();
    } catch (e) {
      print("Error adding transaction: $e");
    }
    // Navigator.pop(context, {
    //   'title': enteredTitle,
    //   'amount': enteredAmount,
    //   'category': category,
    // });
    // widget.addTransaction(selectedTransactionType, enteredAmount);

    // titleController.clear();
    // amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {});
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text('Add Transaction'),
                  );
                },
                body: Column(
                  children: [
                    DropdownButton<String>(
                      value: selectedTransactionType,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTransactionType = newValue!;
                        });
                      },
                      items: [
                        'Grocery',
                        'Fee',
                        'Rent',
                        'Dairy',
                        'Internet',
                        'Utilities',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: titleController,
                      onSubmitted: (_) => _submitData(),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      controller: amountController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onSubmitted: (_) => _submitData(),
                    ),
                    ElevatedButton(
                      onPressed: _submitData,
                      child: Text('Add Transaction'),
                    ),
                  ],
                ),
                isExpanded: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
