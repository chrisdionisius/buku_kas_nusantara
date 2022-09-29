import 'package:buku_kas_nusantara/models/cash_flow.dart';
import 'package:buku_kas_nusantara/widgets/detail_card.dart';
import 'package:flutter/material.dart';

import '../services/db_helper.dart';

class ListCashFlow extends StatefulWidget {
  const ListCashFlow({Key? key}) : super(key: key);

  @override
  State<ListCashFlow> createState() => _ListCashFlowState();
}

class _ListCashFlowState extends State<ListCashFlow> {
  late List<CashFlow> listCashFlow;

  Future initialize() async {
    listCashFlow = [];
    listCashFlow = await DataHelper().selectCashFlow();
    DataHelper().close();
    setState(() {});
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listCashFlow.length,
      itemBuilder: (context, int position) {
        return DetailCard(
          cashFlow: listCashFlow[position],
        );
      },
    );
  }
}
