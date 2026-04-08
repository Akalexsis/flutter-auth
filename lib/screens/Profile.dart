import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  const ProfilePage({super.key, required this.name});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle( fontSize: 24, color: Colors.white ), ),
        backgroundColor: Colors.orange,
      ),
      body: Text('Profile page ${name}'),
    );
  }
}