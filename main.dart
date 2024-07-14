// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:expense_tracker/SplashScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'transaction.dart';
// import 'shared_preferences_helper.dart';
// import 'transaction_list.dart';
// import 'new_transaction.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Expense Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//         hintColor: Colors.amber,
//         fontFamily: 'Quicksand',
//         textTheme: ThemeData.light().textTheme.copyWith(
//           titleMedium: TextStyle(
//             fontFamily: 'OpenSans',
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       home: SplashScreen(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final List<Transaction> _userTransactions = [];
//   final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadTransactions();
//   }
//
//   void _loadTransactions() async {
//     final transactions = await _prefsHelper.getTransactions();
//     setState(() {
//       _userTransactions.addAll(transactions);
//     });
//   }
//
//   void _addNewTransaction(String txTitle, double txAmount, String txCategory) {
//     final newTx = Transaction(
//       id: DateTime.now().toString(),
//       title: txTitle,
//       amount: txAmount,
//       date: DateTime.now(),
//       category: txCategory,
//     );
//
//     setState(() {
//       _userTransactions.add(newTx);
//     });
//
//     _prefsHelper.saveTransactions(_userTransactions);
//   }
//
//   void _startAddNewTransaction(BuildContext ctx) {
//     showModalBottomSheet(
//       context: ctx,
//       builder: (_) {
//         return GestureDetector(
//           onTap: () {},
//           child: NewTransaction(_addNewTransaction),
//           behavior: HitTestBehavior.opaque,
//         );
//       },
//     );
//   }
//
//   double get _totalTransactionsToday {
//     final today = DateTime.now();
//     return _userTransactions.where((tx) {
//       return tx.date.day == today.day &&
//           tx.date.month == today.month &&
//           tx.date.year == today.year;
//     }).fold(0.0, (sum, tx) => sum + tx.amount);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Add your today's transaction",
//           style: GoogleFonts.aBeeZee(
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               SizedBox(height: 10),
//               TransactionList(_userTransactions),
//               Padding(
//                 padding: const EdgeInsets.only(top: 30, left: 10),
//                 child: Text(
//                   'Total transactions today : ₹${_totalTransactionsToday.toStringAsFixed(2)}',
//                   style: GoogleFonts.aBeeZee(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       backgroundColor: Colors.orangeAccent,
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.orangeAccent,
//         items: [
//           Icon(Icons.home),
//           Icon(Icons.add),
//           Icon(Icons.event_note_outlined),
//         ],
//         onTap: (index) {
//           if (index == 1) {
//             _startAddNewTransaction(context);
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:expense_tracker/Monthly_budget.dart';
import 'package:expense_tracker/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';
import 'shared_preferences_helper.dart';
import 'transaction_list.dart';
import 'new_transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        hintColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() async {
    final transactions = await _prefsHelper.getTransactions();
    setState(() {
      _userTransactions.addAll(transactions);
    });
  }

  void _addNewTransaction(String txTitle, double txAmount, String category) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      category: category,
    );

    setState(() {
      _userTransactions.add(newTx);
    });

    _prefsHelper.saveTransactions(_userTransactions);
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });

    _prefsHelper.saveTransactions(_userTransactions);
  }

  double get _totalTransactionsToday {
    final today = DateTime.now();
    return _userTransactions.where((tx) {
      return tx.date.day == today.day &&
          tx.date.month == today.month &&
          tx.date.year == today.year;
    }).fold(0.0, (sum, tx) => sum + tx.amount);
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
      // Handle navigation to home page if needed
        break;
      case 1:
        _startAddNewTransaction(context);
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MonthlyBudgetPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add your today's transaction",
          style: GoogleFonts.aBeeZee(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 10),
              TransactionList(_userTransactions, _deleteTransaction),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
                child: Text(
                  'Total transactions today : ₹${_totalTransactionsToday.toStringAsFixed(2)}',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.orangeAccent,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.orangeAccent,
        items: [
          Icon(Icons.home),
          Icon(Icons.add),
          Icon(Icons.event_note_outlined),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
