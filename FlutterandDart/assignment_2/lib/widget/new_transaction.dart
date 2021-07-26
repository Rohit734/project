import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleinput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime _date;

  void _submitdata() {
    if (_amountInput.text.isEmpty) {
      return;
    }
    // so here we accept
    final titledata = _titleinput.text;
    final amountdata = double.parse(_amountInput.text);
    if (titledata == null || amountdata <= 0 || _date == null) {
      return;
    }
    widget._addNewTransaction(titledata, amountdata, _date);
// close the popup windows
    Navigator.of(context).pop();
  }

  void _percentdatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _date = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              bottom: media.viewInsets.bottom + 10,
              left: 10,
              right: 10,
              top: 10),
          child: Column(
            // aligning widget at start
            crossAxisAlignment: CrossAxisAlignment.end,
            // TextField is used for taking input from user
            children: [
              // Title Input
              TextField(
                decoration: InputDecoration(labelText: 'Title'),

                // onChanged is used to accept every single string that user enters from TextField in val and assign to _titleinput even we can use TextEditingController() as final variable_name = TextEditingController(); then insted of onChanged use Controller: variable_name this works same as onChanged. input Type String

                /*onChanged: (val) {
                    _titleInput = val;
                  }*/
                controller: _titleinput,
                // onSubmitted : react or trigger mobile keyboard ok/enter button
                onSubmitted: (_) => _submitdata(),
              ),

              //Amount Input
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountInput,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitdata(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(_date == null
                          ? "No date Selected"
                          : DateFormat('d/MMM/yyyy').format(_date)),
                    ),
                    FlatButton(
                      child: Text(
                        "Select Date",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _percentdatepicker();
                      },
                    )
                  ],
                ),
              ),
              // FlatButton in order to take some action on user inputs.

              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitdata,
                child: Text("Add transaction"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
