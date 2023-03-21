import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? connectionType;
  String? connectionStatus;
  bool connection = false;

  void checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) {
      setState(() {
        connectionType = 'Mobile';
      });
    } else if (result == ConnectivityResult.wifi) {
      setState(() {
        connectionType = 'wifi';
      });
    } else {
      setState(() {
        connectionType = 'No internet connection';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('Data connection is available.');
          setState(() {
            connection = true;
          });
          break;
        case InternetConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          setState(() {
            connection = false;
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: connection ? Colors.greenAccent : Colors.red,
                ),
              ),
            ),
            Text(
              connectionType ?? '',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              connectionStatus ?? '',
              style: TextStyle(color: Colors.black),
            ),
            ElevatedButton(
                onPressed: () => checkConnection(), child: Text('Check')),
          ],
        ),
      ),
    );
  }
}
