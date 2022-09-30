import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/cash_flow.dart';
import '../services/db_helper.dart';

class GraphCard extends StatefulWidget {
  const GraphCard({Key? key}) : super(key: key);

  @override
  State<GraphCard> createState() => _GraphCardState();
}

class _GraphCardState extends State<GraphCard> {
  late DataHelper dataHelper;
  List<CashFlow>? listCashFlow;
  int maxAmount = 0;
  double maxDate = 0;

  void initData() async {
    listCashFlow = await dataHelper.selectCashFlowByMonth();
    for (CashFlow cashFlow in listCashFlow!) {
      double parsedDate = double.parse(
        cashFlow.date!.split('-')[2].substring(0, 2),
      );
      if (cashFlow.amount! > maxAmount) {
        maxAmount = cashFlow.amount!;
      }
      if (maxDate < parsedDate) {
        maxDate = parsedDate;
      }
    }
    dataHelper.close();
    setState(() {});
  }

  @override
  void initState() {
    dataHelper = DataHelper();
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          minX: 1,
          maxX: maxDate.toDouble(),
          minY: 0,
          maxY: maxAmount.toDouble(),
          lineBarsData: [
            LineChartBarData(
              color: Colors.green,
              spots: (listCashFlow != null)
                  ? [
                      for (CashFlow cashFlow in listCashFlow!)
                        if (cashFlow.type == 0)
                          FlSpot(
                            double.parse(
                              cashFlow.date!.split('-')[2].substring(0, 2),
                            ),
                            cashFlow.amount!.toDouble(),
                          )
                    ]
                  : [],
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              color: Colors.red,
              spots: (listCashFlow != null)
                  ? [
                      for (CashFlow cashFlow in listCashFlow!)
                        if (cashFlow.type == 1)
                          FlSpot(
                            double.parse(
                              cashFlow.date!.split('-')[2].substring(0, 2),
                            ),
                            cashFlow.amount!.toDouble(),
                          ),
                    ]
                  : [],
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
        ),
      );
}
