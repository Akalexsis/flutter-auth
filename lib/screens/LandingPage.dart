import 'package:flutter/material.dart';
import '../firebase_options.dart';
import './Register.dart';
import './Login.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Text(
                        'Welcome to the app! Login or create an account to get started',
                        style: TextStyle( fontSize: 30, color: Colors.white ),
                        textAlign: TextAlign.left
                        ),
                    

                    // route users to create new account
                    ElevatedButton(
                        onPressed: () {
                            Navigator.push( context,
                                MaterialPageRoute( builder: (context) => RegisterPage(),),
                            );
                        },
                        style: ElevatedButton.styleFrom( backgroundColor: Colors.white ),
                        child: Text('Create Account', style: TextStyle( fontSize: 18, color: Colors.orange ), ),
                    ),

                    // let users login with existing account
                    ElevatedButton(
                        onPressed: () {
                            Navigator.push( context,
                                MaterialPageRoute( builder: (context) => LoginPage(),),
                            );
                        },
                        style: ElevatedButton.styleFrom( backgroundColor: Colors.transparent ),
                        child: Text('Login', style: TextStyle( fontSize: 18, color: Colors.white ), ),
                    ),
                ]
            ),
        ),
    );
  }
}
