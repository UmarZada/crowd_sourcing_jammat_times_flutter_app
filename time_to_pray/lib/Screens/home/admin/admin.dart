import 'package:flutter/material.dart';
import 'package:time_to_pray/Screens/home/admin/approved.dart';
import 'package:time_to_pray/Screens/home/admin/upcommings.dart';

class AdminControlScreen extends StatefulWidget {
  const AdminControlScreen({super.key});

  @override
  State<AdminControlScreen> createState() => _AdminControlScreenState();
}

class _AdminControlScreenState extends State<AdminControlScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Controls"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.arrow_circle_down_sharp,
                size: 35.0,
                color: Colors.amber.shade800,
              ),
            ),
            const Tab(
              icon: Icon(
                Icons.check_circle_sharp,
                size: 35.0,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          UpCompingRequest(),
          ApprovedRequests(),
        ],
      ),
    );
  }
}
