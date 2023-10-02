import 'package:flutter/material.dart';
import 'package:yamabico/route_type.dart';

class GuestTopScreen extends StatelessWidget {
  const GuestTopScreen({super.key});

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
          padding: const EdgeInsets.fromLTRB(0, 150.0, 0, 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Yamabico',
                style: TextStyle(fontSize: 35.0, color: Colors.white),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteType.login().value(),
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
            ],
          ),
        ),
      ),
    );
  }
}
