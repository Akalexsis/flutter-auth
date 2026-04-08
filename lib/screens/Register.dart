import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';
import '../service/Auth.dart';
import './Profile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // initialize authentication service
  final AuthService _authService = AuthService();
  final _key = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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

  // void _registerUser(String name, String email, String password) async {
  //   await _authService().register();

  //   _clearForm();

  //   // navigate to Profile Page
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => ProfilePage(name: name),
  //       ),
  //   );
  // }

  void _clearForm() {
    setState(() {
      _nameController.text = '';
      _emailController.text = '';
      _passwordController.text = '';
      _confirmPswdController.text = '';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPswdController.dispose();
    super.dispose();
  }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account', style: TextStyle( fontSize: 24, color: Colors.white ), ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              // USER NAME
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if ( value == null || value.isEmpty ) return 'Name is required';
                  else return null;
                }
              ),
              const SizedBox(height: 16),

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
                    _clearForm();
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),

                child: Text('Create Account', style: TextStyle( fontSize: 12, color: Colors.white ), ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
