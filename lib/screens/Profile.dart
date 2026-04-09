import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';
import '../service/Auth.dart';
import './LandingPage.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;
  const ProfilePage({super.key, required this.name, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // store values passed to page
  late String name;
  late String email;

  final AuthService _authService = AuthService();
  
  @override
  void initState() {
    name = widget.name;
    email = widget.email;
    super.initState();
  }

  // use service class sign-out method to signout user 
  void _signOut() async {
    await _authService.signOut();
    
    // redirect to home page
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => LandingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle( fontSize: 24, color: Colors.white ), ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // DISPLAY USER INFO
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.orange,
                ),
                SizedBox( width: 25 ),
                Column(
                  children: [
                    // Text('Profile page ${name}', style: TextStyle( fontSize: 24 ) ),
                    // Text('${email}', style: TextStyle( fontSize: 18 ) ),
                    Text('Name', style: TextStyle( fontSize: 24, ),  ),
                    SizedBox( height: 12 ),
                    Text('email', style: TextStyle( fontSize: 18 ) ),
                  ]
                ),
              ]
            ),
            SizedBox( height: 24 ),

            // implement signout button to end user session
            ElevatedButton(
              onPressed: () { _signOut(); },
              style: ElevatedButton.styleFrom( backgroundColor: Colors.orange ),
              child: Text('Sign Out', style: TextStyle( fontSize: 18, color: Colors.white ) ),
            ),
          ]
        ),
      ),
    );
  }
}