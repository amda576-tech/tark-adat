import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(TarkAdatApp());
}

class TarkAdatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ترک عادت',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HabitTrackerPage(),
    );
  }
}

class HabitTrackerPage extends StatefulWidget {
  @override
  _HabitTrackerPageState createState() => _HabitTrackerPageState();
}

class _HabitTrackerPageState extends State<HabitTrackerPage> {
  int days = 0;

  @override
  void initState() {
    super.initState();
    _loadDays();
  }

  _loadDays() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      days = prefs.getInt("days") ?? 0;
    });
  }

  _incrementDays() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      days++;
    });
    prefs.setInt("days", days);
  }

  _resetDays() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      days = 0;
    });
    prefs.setInt("days", days);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ترک عادت")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "روزهای موفقیت شما:",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 10),
            Text(
              "$days روز",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementDays,
              child: Text("امروز هم موفق بودم"),
            ),
            ElevatedButton(
              onPressed: _resetDays,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("ریست"),
            ),
          ],
        ),
      ),
    );
  }
}
