import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';
import '../service/Auth.dart';
import './Profile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // initialize authentication service
  final AuthService _authService = AuthService();
  final _key = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // change visibility for password fields
  bool isPasswordHidden = true;

  // toggle visibility for password fields
  void _setPasswordVisibility() {
      setState(() { isPasswordHidden = !isPasswordHidden; } );
  }

  void _loginUser( String email, String password) async {
    await _authService.signIn(email, password );

    // navigate to Profile Page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ProfilePage(email: email),
      ),
    );
    
    _clearForm();
  }

  void _clearForm() {
    setState(() {
      _emailController.text = '';
      _passwordController.text = '';
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle( fontSize: 24, color: Colors.white ), ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              // EMAIL FIELD
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                ),
                validator: (value) {
                if (value == null || value.isEmpty) return 'Please enter your email';
                if (!value.contains('@')) return 'Please enter a valid email';
                else return null;
                },
              ),
              const SizedBox(height: 16),
              
              // PASSWORD FIELD
              TextFormField(
                controller: _passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  // add visibility toggle to password field
                  suffixIcon: IconButton(
                    icon: Icon( isPasswordHidden ? Icons.visibility_off : Icons.visibility),
                    onPressed: _setPasswordVisibility,
                  ),
                ),
                
                  validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a password'; 
                  if (value.length < 6) return 'Password must be at least 6 characters';
                  else return null; // do nothing if input correct
                  },
                ),
                const SizedBox(height: 16),


              ElevatedButton(
                onPressed: () {
                  // validate input before submitting form
                  if ( _key.currentState!.validate() ) {
                    _loginUser( _emailController.text, _passwordController.text );
                  }
                },

                style: ElevatedButton.styleFrom( backgroundColor: Colors.orange, ),
                child: Text('Login', style: TextStyle( fontSize: 18, color: Colors.white ), ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
