import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'shared_preferences_helper.dart';
import 'monthly_summary.dart'; // Import the MonthlySummary model

class MonthlyBudgetPage extends StatefulWidget {
  @override
  _MonthlyBudgetPageState createState() => _MonthlyBudgetPageState();
}

class _MonthlyBudgetPageState extends State<MonthlyBudgetPage> {
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();
  late Future<List<MonthlySummary>> _monthlySummaries;

  @override
  void initState() {
    super.initState();
    _monthlySummaries = _prefsHelper.getMonthlySummaries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monthly Budget',
          style: GoogleFonts.aBeeZee(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<List<MonthlySummary>>(
        future: _monthlySummaries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                MonthlySummary summary = snapshot.data![index];
                return ListTile(
                  title: Text('${DateFormat.MMMM().format(DateTime(summary.year, summary.month))} ${summary.year}'),
                  subtitle: Text('Total Transactions: ₹${summary.totalTransactions.toStringAsFixed(2)}'),
                  //trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Handle onTap to navigate to detailed monthly view if needed
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
