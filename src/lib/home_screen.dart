import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/main.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/login',
              );
            },
            label: const Text('Start'),
            icon: const Icon(Icons.arrow_forward_ios),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
              backgroundColor: Colors.deepOrange,
              textStyle: const TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}
