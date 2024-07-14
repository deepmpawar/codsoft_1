// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'transaction.dart';
//
// class TransactionList extends StatelessWidget {
//   final List<Transaction> transactions;
//
//   TransactionList(this.transactions);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         height: 500,
//         child: transactions.isEmpty
//             ? Column(
//           children: <Widget>[
//             SizedBox(height: 50),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'No transactions added yet!',
//                 style: GoogleFonts.aBeeZee(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 35,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               height: 200,
//             ),
//           ],
//         )
//             : ListView.builder(
//           itemBuilder: (ctx, index) {
//             return Card(
//               elevation: 5,
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   radius: 30,
//                   child: Padding(
//                     padding: EdgeInsets.all(6),
//                     child: FittedBox(
//                       child: Text(
//                         '₹${transactions[index].amount.toStringAsFixed(2)}',
//                         style: GoogleFonts.lato(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   backgroundColor: Theme.of(context).primaryColor,
//                 ),
//                 title: Text(
//                   transactions[index].title,
//                   style: GoogleFonts.lato(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       DateFormat.yMMMd().format(transactions[index].date),
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       'Category: ${transactions[index].category}',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//           itemCount: transactions.length,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) deleteTx; // Function to delete a transaction by ID

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 500,
        child: transactions.isEmpty
            ? Column(
          children: <Widget>[
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No transactions added yet!',
                style: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.w900,
                  fontSize: 35,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
            ),
          ],
        )
            : ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text(
                        '₹${transactions[index].amount.toStringAsFixed(2)}',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                title: Text(
                  transactions[index].title,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Category: ${transactions[index].category}',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteTx(transactions[index].id),
                ),
              ),
            );
          },
          itemCount: transactions.length,
        ),
      ),
    );
  }
}
