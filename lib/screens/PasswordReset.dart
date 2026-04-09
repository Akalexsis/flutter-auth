import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';
import '../service/Auth.dart';
import './Login.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});
  

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  // initialize authentication service
  final AuthService _authService = AuthService();
  final _key = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPswdController = TextEditingController();

  // change visibility for password fields
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  // toggle visibility for password fields
    void _setPasswordVisibility() {
        setState(() { isPasswordHidden = !isPasswordHidden; } );
    }

    void _setConfirmPasswordVisibility() {
        setState(() { isConfirmPasswordHidden = !isConfirmPasswordHidden; } );
    }

  void _resetPassword(String password) async {
    await _authService.changePassword( password );

    // navigate to Profile Page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute( builder: (context) => LoginPage(), ),
    );
    
    _clearForm();
  }

  void _clearForm() {
    setState(() {
      _passwordController.text = '';
      _confirmPswdController.text = '';
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPswdController.dispose();
    super.dispose();
  }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password', style: TextStyle( fontSize: 24, color: Colors.white ), ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
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

                // PASSWORD CONFIRMATION
                TextFormField(
                    controller: _confirmPswdController,
                    obscureText: isConfirmPasswordHidden,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                          icon: Icon( isConfirmPasswordHidden ? Icons.visibility_off : Icons.visibility),
                          onPressed: _setConfirmPasswordVisibility,
                      ),
                    ),
                    validator: (value) {
                        // compare data in password field to value in this field
                        if ( value == null  || value.isEmpty ) return 'Confirmation password required';
                        if ( value != _passwordController.text ) return 'Passwords do not match';
                        else return null; // do nothing if everything correct
                    }
                ),
                const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  // validate input before submitting form
                  if ( _key.currentState!.validate() ) {
                    _resetPassword( _passwordController.text );
                  }
                },

                style: ElevatedButton.styleFrom( backgroundColor: Colors.orange, ),
                child: Text('Submit', style: TextStyle( fontSize: 18, color: Colors.white ), ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
