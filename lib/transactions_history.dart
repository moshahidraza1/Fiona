import 'package:flutter/material.dart';
import 'transactions_input.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//
class Transactions extends StatefulWidget {
  Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactionsFromFirebase();
  }

  Future<void> _loadTransactionsFromFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot transactionQuery =
        await firestore.collection('transactions').get();

    List<Transaction> loadedTransactions = [];

    for (QueryDocumentSnapshot doc in transactionQuery.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final title = data['title'] as String;
      final amount = data['amount'] as double;
      final category = data['category'] as String;

      final newTransaction = Transaction(
        title: title,
        amount: amount,
        category: category,
        date: null, // Set the date to null or provide a default date
      );

      loadedTransactions.add(newTransaction);
    }
    // void _addTransaction(String title, double amount, String category) {
    //   final newTransaction = Transaction(
    //     title: title,
    //     amount: amount,
    //     date: DateTime.now(),
    //     category: category,
    //   );
    setState(() {
      // transactions.add(newTransaction);
      transactions.addAll(loadedTransactions);
    });
  }

  // Create a new variable to store the selected category
  String? selectedCategory;

  Future<void> _navigateToTransactionInput() async {
    final result = await Navigator.pushNamed(context, '/transactions_input');
    if (result != null) {
      final transactionData = result as Map<String, dynamic>;
      final title = transactionData['title'] as String;
      final amount = transactionData['amount'] as double;
      final category = transactionData['category'] as String;

      // Convert category to lowercase for debugging
      final lowercaseCategory = category.toLowerCase();

      final newTransaction = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        category: lowercaseCategory,
      );

      setState(() {
        transactions.add(newTransaction);
      });
    }
  }

  void calculateAndPrintCategorySums() {
    final Map<String?, double> categorySums = {};

    for (Transaction transaction in transactions) {
      final category = transaction.category;
      final amount = transaction.amount;

      // Initialize the category sum if it doesn't exist
      if (category != null) {
        categorySums[category] = (categorySums[category] ?? 0.0) + amount;
      }
    }
    // return categorySums;
    //Print the category sums
    categorySums.forEach((category, sum) {
      if (category != null) {
        print("Category: $category, Sum: $sum");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: Column(
        children: [
          // ...

          // TransactionHistory widgets
          ...transactions.map((tx) => TransactionHistory(
                title: tx.title,
                amount: tx.amount,
                category: tx.category,
              )),
          // Pass the instance of _TransactionsState to HomePage
          // HomePage(transactionsState: this),

          // Button to add new transaction

          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              // onPressed: _navigateToTransactionInput,
              onPressed: () {
                _navigateToTransactionInput();
              },

              child: Text('Add New Transaction'),
            ),
          ),
        ],
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
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => HomePage(
              //         icons: categoryIcons[category],
              //         category: category,
              //         amount: calculateAndPrintCategorySums())));

              // Navigator.pushNamed(context, '/home_page');
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

class Transaction {
  final String title;
  final double amount;
  final DateTime? date;
  final String? category;

  Transaction(
      {required this.title,
      required this.amount,
      this.date,
      required this.category});
}

class TransactionHistory extends StatelessWidget {
  final Map<String, IconData> categoryIcons = {
    'grocery': Icons.shopping_cart,
    'fee': Icons.money,
    'rent': Icons.home,
    'dairy': Icons.emoji_food_beverage,
    'internet': Icons.wifi,
    'utilities': Icons.lightbulb,
  };

  final String title;
  final double amount;
  final String? category;

  TransactionHistory(
      {required this.title, required this.amount, this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            // Display the icon based on the selected category
            child: Icon(
              categoryIcons[category] ?? Icons.school,
              color: Colors.black38,
              // tooltip: category,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Rs ${amount.toStringAsFixed(1)}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(TransactionApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TransactionApp());
}

class TransactionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Transactions(),
    );
  }
}
