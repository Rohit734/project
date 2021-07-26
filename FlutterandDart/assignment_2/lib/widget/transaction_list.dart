import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final deletefunction;
// receiving list of Transaction instance or data.
  TransactionList(this.userTransaction, this.deletefunction);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    //we are adding scrolling feature to a container using SingleChildScrollView this will make container scrollable
    return userTransaction.isEmpty
        ? LayoutBuilder(builder: (context, constrain) {
            return Column(
              children: [
                Text("No Data", style: Theme.of(context).textTheme.title),
                //provide Empty space
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constrain.maxHeight * 0.6,
                  child: Image.asset(
                    'image/youtube.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            // fetching every single data from userTransaction by using map(){} .... this means we are appending return widget to outer list
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                            child: Text('\$${userTransaction[index].amount}'))),
                  ),
                  title: Text(
                    userTransaction[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(DateFormat('d/MMM/yyyy')
                      .format(userTransaction[index].date)),
                  trailing: media.size.width > 460
                      ? FlatButton.icon(
                          textColor: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                          label: Text("Delete"),
                          onPressed: () {
                            deletefunction(userTransaction[index].id);
                            print("index $index");
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            deletefunction(userTransaction[index].id);
                            print("index $index");
                          },
                        ),
                ),
              );
            },
            itemCount: userTransaction.length,
          );
  }
}
