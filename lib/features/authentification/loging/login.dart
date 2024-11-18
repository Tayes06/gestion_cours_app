import 'package:flutter/material.dart';
import 'package:gestion_cours_app/helper_functions.dart';
import 'package:gestion_cours_app/sizes.dart';
import 'package:gestion_cours_app/styles/spacing_styles.dart';
import 'package:get/get.dart';

class LogingScreen extends StatefulWidget {
  LogingScreen({super.key});

  @override
  State<LogingScreen> createState() => _LogingScreenState();
}

class _LogingScreenState extends State<LogingScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isObscure = true;
  // Track password visibility
  @override
  Widget build(BuildContext context) {
    final dark = ThelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),

              /// logo title & sub title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(height: 150, image: AssetImage("assets/app-logo.png"))
                ],
              ),

              SizedBox(
                height: 20,
              ),

              Text(
                "CONNEXION",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),

              ///Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// Username or email
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username ou Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre username email';
                        }
                        return null;
                      },
                    ),

                    /// password
                    TextFormField(
                      obscureText: _isObscure, // Hide the password
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure =
                                  !_isObscure; // Toggle password visibility
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    /// Button
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Connexion en cours...'),
                            ),
                          );
                        }
                      },
                      child: const Text('Se connecter'),
                    ),

                    SizedBox(
                      height: 40,
                    ),

                    Text(
                      "Copyright 2024, Ing School",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
