import 'package:flutter/material.dart';
import 'package:time_to_pray/Screens/home/quran/juz_screen.dart';
import 'package:time_to_pray/Screens/home/quran/surah_screen.dart';

class MainQuranScreen extends StatefulWidget {
  const MainQuranScreen({super.key});

  @override
  State<MainQuranScreen> createState() => _MainQuranScreenState();
}

class _MainQuranScreenState extends State<MainQuranScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recite Quran"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        //color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0, top: 15.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.grey[200]),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      child: Text("Juz"),
                    ),
                    Tab(
                      child: Text("Surah"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    //========== First -All tab
                    JuzScreen(),
                    //======  tab bar view widget Expense
                    //------
                    SurahScreen(),

                    //---- End of second
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
