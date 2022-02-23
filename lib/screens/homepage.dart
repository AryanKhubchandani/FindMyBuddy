import 'package:find_my_buddy/screens/dashboard.dart';
import 'package:find_my_buddy/screens/settings.dart';
import 'package:find_my_buddy/screens/uploadpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _page = 0;
  late PageController _c;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    _c = PageController(
      keepPage: true,
      initialPage: _page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find My Buddy"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
        selectedIconTheme: IconThemeData(color: _getColor()),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _page,
        selectedItemColor: _getColor(),
        onTap: (index) {
          _c.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOutSine);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: PageView(
        controller: _c,
        onPageChanged: (newPage) {
          setState(() {
            _page = newPage;
          });
        },
        children: <Widget>[Dashboard(), UploadPage(), SettingsPage()],
      ),
    );
  }

  Color? _getColor() {
    switch (_page) {
      case 0:
        return Colors.indigo;
      case 1:
        return Colors.brown;
      case 2:
        return Colors.green[900];
      default:
        return Colors.indigo;
    }
  }
}
