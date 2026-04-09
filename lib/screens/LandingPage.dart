import 'package:flutter/material.dart';
import '../firebase_options.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [Text('Landing Page'),
                ]
            ),
        ),
    );
  }
}
