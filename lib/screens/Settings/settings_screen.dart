import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              children: [
                profileRow(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  profileRow() {
    return Row(
      children: const [
        CircleAvatar(
          child: Icon(Icons.person),
        ),
        Text('John Wick')
      ],
    );
  }
}
