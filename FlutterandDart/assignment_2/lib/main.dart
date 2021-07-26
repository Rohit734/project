import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widget/chart.dart';
import './widget/new_transaction.dart';
import './data/transaction.dart';
import './widget/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      //them is used to set default color,fonts and etc

      theme: ThemeData(
        //primarySwatch provide us with color shade of same color where as primary color provide us with only one color.
        primarySwatch: Colors.purple,
        //alternate color
        accentColor: Colors.amber,
        //adding new default font we need to edit yml file also
        //fontFamily: 'Remachine'
        //defult appbar font now All text in a appbar will inherit ths font

        //text them for all text into our app

        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(fontFamily: 'Remachine', fontSize: 40),
              button: TextStyle(color: Colors.white),
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
  // declaring List
  final List<Transaction> _userTransaction = [
    Transaction(id: 't1', title: 'Shoes', amount: 1, date: DateTime.now()),
    Transaction(id: 't2', title: 'Boot', amount: 1, date: DateTime.now())
  ];
  bool _showChart = false;
//old data

  List<Transaction> get recentTranaction {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

//adding new transaction
  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

//bottom sheet
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
    /* use for gesture  onTap means whenever we tap it will do nothing to showModalBottomSheet
      return gesture(
        onTap:(){},
        behavior: HitTestBehavior.Opaque
      ) */
  }

// delete Transaction
  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) {
        return element.id == id;
      });
    });
  }

// builder method for landscape view
  List<Widget> _buildLandscape(
      MediaQueryData media, AppBar Appbar, Widget listitem) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("show chart"),
          //adaptive is a constructure and automatic adjust style according to platform but all widget doesn't have this constructor
          Switch.adaptive(
              value: _showChart,
              onChanged: (value) {
                setState(() {
                  _showChart = value;
                });
              }),
        ],
      ),
      _showChart
          ? Container(
              height: (media.size.height -
                      Appbar.preferredSize.height -
                      media.padding.top) *
                  0.7,
              child: Chart(recentTranaction))
          :
          // call Transaction from tranaction_list which will display data
          //SizedBox(height: 10),
          listitem,
    ];
  }
// builder method for Portrait view
  List<Widget> _buildPortrait(
      MediaQueryData media, AppBar Appbar, Widget listitem) {
    return [
      Container(
          height: (media.size.height -
                  Appbar.preferredSize.height -
                  media.padding.top) *
              0.3,
          child: Chart(recentTranaction)),
      listitem,
    ];
  }

//builder method for app bar
  Widget _buildAppbar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Adding icon
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startAddNewTransaction(context)),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    //checks device orientation
    final islandscape = media.orientation == Orientation.landscape;
    //appbar
    final PreferredSizeWidget Appbar = _buildAppbar();

    // list
    final listitem = Container(
        height: (media.size.height -
            Appbar.preferredSize.height -
            media.padding.top),
        child: TransactionList(_userTransaction, _deleteTransaction));

    // body
    final pagebody = SingleChildScrollView(
      // SingleChildScroleView adds scrolling feature it works with rows and column
      child: Column(
        //streatching widget
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (islandscape) ..._buildLandscape(media, Appbar, listitem),
          if (!islandscape) ..._buildPortrait(media, Appbar, listitem),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pagebody,
            navigationBar: Appbar,
          )
        : Scaffold(
            appBar: Appbar,
            body: pagebody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
