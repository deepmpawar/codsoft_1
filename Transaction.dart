// import 'dart:convert';
//
// class Transaction {
//   final String id;
//   final String title;
//   final double amount;
//   final DateTime date;
//
//   Transaction({
//     required this.id,
//     required this.title,
//     required this.amount,
//     required this.date,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'amount': amount,
//       'date': date.toIso8601String(),
//     };
//   }
//
//   factory Transaction.fromMap(Map<String, dynamic> map) {
//     return Transaction(
//       id: map['id'],
//       title: map['title'],
//       amount: map['amount'],
//       date: DateTime.parse(map['date']),
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source));
// }
import 'dart:convert';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category; // Add the category field

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category, // Initialize the category field
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category, // Include the category in the map
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: map['category'], // Parse the category from the map
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source));
}
