import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF364A84), // Dark blue color
        title: Text('Home page'),
      ),
      body: Center(
        child: Text('Welcome to the Home page!'),
     ),
);
}
}