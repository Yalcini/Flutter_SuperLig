import 'package:flutter/material.dart';
import 'package:flutter_application_4/page/futbolcular_page.dart';
import 'package:flutter_application_4/page/teknik_ekip_page.dart';
import 'package:flutter_application_4/page/yonetim_page.dart';

class Bilgiler extends StatefulWidget {
  final takim;
  const Bilgiler({Key? key, required this.takim}) : super(key: key);

  @override
  State<Bilgiler> createState() => _BilgilerState();
}

class _BilgilerState extends State<Bilgiler> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(
                child: Text("Futbolcular"),
              ),
              Tab(child: Text("Teknik Ekip"),),
              Tab(child: Text("Yönetim"),)
            ]),
          ),
          body: TabBarView(
            children: [
              Futbolcular(takim: widget.takim),
              TeknikEkipPage(takim: widget.takim),
              YonetimPage(takim: widget.takim)
              ] ),
        ));
  }
}
