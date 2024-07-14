// import 'package:flutter/material.dart';
//
// class NewTransaction extends StatefulWidget {
//   final Function addTx;
//
//   NewTransaction(this.addTx);
//
//   @override
//   _NewTransactionState createState() => _NewTransactionState();
// }
//
// class _NewTransactionState extends State<NewTransaction> {
//   final _titleController = TextEditingController();
//   final _amountController = TextEditingController();
//
//   void _submitData() {
//     if (_amountController.text.isEmpty) {
//       return;
//     }
//     final enteredTitle = _titleController.text;
//     final enteredAmount = double.parse(_amountController.text);
//
//     if (enteredTitle.isEmpty || enteredAmount <= 0) {
//       return;
//     }
//
//     widget.addTx(
//       enteredTitle,
//       enteredAmount,
//     );
//
//     Navigator.of(context).pop();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       child: Container(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             TextField(
//               decoration: InputDecoration(labelText: 'Title'),
//               controller: _titleController,
//               onSubmitted: (_) => _submitData(),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Amount'),
//               controller: _amountController,
//               keyboardType: TextInputType.number,
//               onSubmitted: (_) => _submitData(),
//             ),
//             TextButton(
//               child: Text('Add Transaction', style: TextStyle(color: Colors.purple),),
//               onPressed: _submitData,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'Home'; // Default category

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedCategory.isEmpty) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedCategory,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: <String>['Home', 'Personal', 'Office', 'Others']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purple),
              ),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
