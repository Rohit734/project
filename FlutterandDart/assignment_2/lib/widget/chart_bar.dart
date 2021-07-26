import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double amountPercentage;

  ChartBar(this.label, this.amount, this.amountPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(
        children: [
          Container(
              height: constrains.maxHeight*0.15,
              child: FittedBox(child: Text("\$${amount.toStringAsFixed(0)}"))),
          SizedBox(height: constrains.maxHeight * 0.05),
          Container(
            height: constrains.maxHeight*0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 2),
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: amountPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constrains.maxHeight * 0.05),
          Container(height: constrains.maxHeight * 0.15,child: Text(label)),
        ],
      );
    });
  }
}
