import 'package:flutter/material.dart';

import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import '../widgets/new_transaction.dart';
import '../models/transaction.dart';
import '../widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(
            color: Colors.white
          ),

        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransaction =[];
  
  List <Transaction> get _recentTransaction{
    return _userTransaction.where((tx){
      return tx.date.isAfter(
          DateTime.now().subtract(
              Duration(days: 7),
          )
      );
    }).toList();
  }

  bool _showChart = false;

  void _addNewTransaction(String txTitle, int txAmount, DateTime chosenDate){
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: (){},
        child: NewTransaction (_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expenses',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon (
                Icons.add
            ),
            onPressed: () => _startAddNewTransaction(context)
        ),
      ],
    );

    final txListWidget = Container(
        height: (mediaQuery.size.height
            - appBar.preferredSize.height
            - mediaQuery.padding.top) *0.7,
        child: TransactionList(_userTransaction, _deleteTransaction)
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart'),
                Switch(
                  value: _showChart, onChanged: (val){
                    setState(() {
                      _showChart = val;
                    }
                    );
                },
                ),
              ],
            ),
            if (!isLandscape) Container(
                height: (mediaQuery.size.height
                    - appBar.preferredSize.height
                    - mediaQuery.padding.top) * 0.25,
                child: Chart(_recentTransaction)
            ),
            if(!isLandscape) txListWidget,
            if(isLandscape) _showChart
            ? Container(
              height: (mediaQuery.size.height
                  - appBar.preferredSize.height
                  - mediaQuery.padding.top) * 0.7,
                child: Chart(_recentTransaction)
            )
                : txListWidget
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
