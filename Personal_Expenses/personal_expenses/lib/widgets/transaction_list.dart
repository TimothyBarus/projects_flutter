import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deletTx;

  TransactionList(this.transactions, this.deletTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
        child: transactions.isEmpty ? LayoutBuilder(
          builder: (ctx, constrain){
            return Column(
              children: <Widget>[
                Text('No Transaction Added Yet',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 15,
                ),
                Container(
                  height: constrain.maxHeight * 0.6,
                  child: Image.asset('assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          }
        )
        : ListView.builder(
          itemBuilder: (ctx, index){
            return Card(
                margin: EdgeInsets.symmetric(
                    vertical: 8, horizontal: 5
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text('Rp\.${transactions[index].amount}'
                        ),
                      ),
                    ),
                  ),
                  title: Text(transactions[index].title,
                  style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                    onPressed: () => deletTx(transactions[index].id),
                    icon: Icon(Icons.delete),
                    label: Text('Delete'),
                    textColor: Theme.of(context).errorColor,
                  )
                  : IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deletTx(transactions[index].id),
                  ),
                ),
            );
          },
          itemCount: transactions.length,
        ),
      );
  }
}
