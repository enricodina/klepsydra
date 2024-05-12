import 'package:flutter/material.dart';
import 'chart_tab.dart';
import 'filter_tab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klepsydra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Klepsydra'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Chart'),
              Tab(text: 'Filter'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ChartTab(),
            FilterTab(),
          ],
        ),
      ),
    );
  }
}
