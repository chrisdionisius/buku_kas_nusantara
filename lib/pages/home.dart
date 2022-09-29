import 'package:buku_kas_nusantara/models/cash_flow.dart';
import 'package:buku_kas_nusantara/models/menu.dart';
import 'package:buku_kas_nusantara/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Menu> _listMenu = [
  Menu(
    name: 'Tambah Pemasukan',
    icon: '',
    route: '/pemasukan',
  ),
  Menu(
    name: 'Tambah Pengeluaran',
    icon: '',
    route: '/pengeluaran',
  ),
  Menu(
    name: 'Detail Cashflow',
    icon: '',
    route: '/cashFlow',
  ),
  Menu(
    name: 'Pengaturan',
    icon: '',
    route: '/pengaturan',
  ),
];
final formatter = NumberFormat("#,##0.00", "en_US");

class _HomePageState extends State<HomePage> {
  int _pengeluaran = 0;
  int _pemasukan = 0;

  late DataHelper dataHelper;
  int count = 0;

  @override
  void initState() {
    dataHelper = DataHelper();
    initData();
    super.initState();
  }

  void initData() async {
    List<CashFlow> listCashFlow = await dataHelper.selectCashFlow();
    for (CashFlow cashFlow in listCashFlow) {
      if (cashFlow.type == 0) {
        _pemasukan += cashFlow.amount!;
      } else {
        _pengeluaran += cashFlow.amount!;
      }
    }
    dataHelper.close();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: const Text(
                'Rangkuman Bulan Ini',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Pengeluaran: Rp ${formatter.format(_pengeluaran)}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent, fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Pemasukan: Rp ${formatter.format(_pemasukan)}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 20),
              ),
            ),
            Container(
              height: height / 3,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: height - 300,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: <Widget>[
                  for (Menu menu in _listMenu)
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, menu.route!);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('logo.png', width: height / 5),
                          Text(
                            menu.name!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
