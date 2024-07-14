// import 'package:shared_preferences/shared_preferences.dart';
// import 'transaction.dart';
//
// class SharedPreferencesHelper {
//   static const String _transactionsKey = 'transactions';
//
//   Future<void> saveTransactions(List<Transaction> transactions) async {
//     final prefs = await SharedPreferences.getInstance();
//     final List<String> jsonList = transactions.map((tx) => tx.toJson()).toList();
//     prefs.setStringList(_transactionsKey, jsonList);
//   }
//
//   Future<List<Transaction>> getTransactions() async {
//     final prefs = await SharedPreferences.getInstance();
//     final List<String>? jsonList = prefs.getStringList(_transactionsKey);
//
//     if (jsonList == null) return [];
//
//     return jsonList.map((json) => Transaction.fromJson(json)).toList();
//   }
// }

// import 'package:shared_preferences/shared_preferences.dart';
// import 'transaction.dart';
// import 'monthly_summary.dart'; // Import the MonthlySummary model
//
// class SharedPreferencesHelper {
//   static const String _transactionsKey = 'transactions';
//
//   Future<void> saveTransactions(List<Transaction> transactions) async {
//     final prefs = await SharedPreferences.getInstance();
//     final List<String> jsonList = transactions.map((tx) => tx.toJson()).toList();
//     prefs.setStringList(_transactionsKey, jsonList);
//   }
//
//   Future<List<Transaction>> getTransactions() async {
//     final prefs = await SharedPreferences.getInstance();
//     final List<String>? jsonList = prefs.getStringList(_transactionsKey);
//
//     if (jsonList == null) return [];
//
//     return jsonList.map((json) => Transaction.fromJson(json)).toList();
//   }
//
//   Future<List<MonthlySummary>> getMonthlySummaries() async {
//     final List<Transaction> transactions = await getTransactions();
//     final Map<String, double> monthlyTotal = {};
//
//     transactions.forEach((tx) {
//       String key = '${tx.date.year}-${tx.date.month}';
//       if (monthlyTotal.containsKey(key)) {
//         monthlyTotal[key]! += tx.amount;
//       } else {
//         monthlyTotal[key] = tx.amount;
//       }
//     });
//
//     List<MonthlySummary> summaries = monthlyTotal.entries.map((entry) {
//       List<String> parts = entry.key.split('-');
//       return MonthlySummary(
//         year: int.parse(parts[0]),
//         month: int.parse(parts[1]),
//         totalTransactions: entry.value,
//       );
//     }).toList();
//
//     return summaries;
//   }
// }

import 'package:shared_preferences/shared_preferences.dart';
import 'transaction.dart';
import 'monthly_summary.dart'; // Import the MonthlySummary model

class SharedPreferencesHelper {
  static const String _transactionsKey = 'transactions';

  Future<void> saveTransactions(List<Transaction> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = transactions.map((tx) => tx.toJson()).toList();
    prefs.setStringList(_transactionsKey, jsonList);
  }

  Future<List<Transaction>> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_transactionsKey);

    if (jsonList == null) return [];

    return jsonList.map((json) => Transaction.fromJson(json)).toList();
  }

  Future<List<MonthlySummary>> getMonthlySummaries() async {
    final List<Transaction> transactions = await getTransactions();
    final Map<String, double> monthlyTotal = {};

    transactions.forEach((tx) {
      String key = '${tx.date.year}-${tx.date.month}';
      if (monthlyTotal.containsKey(key)) {
        monthlyTotal[key] = monthlyTotal[key]! + tx.amount; // Adjusted assignment here
      } else {
        monthlyTotal[key] = tx.amount;
      }
    });

    List<MonthlySummary> summaries = monthlyTotal.entries.map((entry) {
      List<String> parts = entry.key.split('-');
      return MonthlySummary(
        year: int.parse(parts[0]),
        month: int.parse(parts[1]),
        totalTransactions: entry.value,
      );
    }).toList();

    return summaries;
  }
}

