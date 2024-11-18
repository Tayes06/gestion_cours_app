import 'package:flutter/material.dart';
import 'package:gestion_cours_app/features/authentification/loging/login.dart';
import 'package:gestion_cours_app/navigation_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de cours',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AcceuilPage(),
    );
  }
}

class AcceuilPage extends StatelessWidget {
  const AcceuilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceuil'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LogoEcole(),
            SizedBox(
              height: 20,
            ),
            MessageBienvenue(),
            SizedBox(
              height: 20,
            ),
            BoutonSession(),
            SizedBox(
              height: 20,
            ),
            LogingButton(),
          ],
        ),
      ),
    );
  }
}

class LogoEcole extends StatelessWidget {
  const LogoEcole({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/app-logo.png',
      width: 200,
      height: 200,
    );
  }
}

class MessageBienvenue extends StatelessWidget {
  const MessageBienvenue({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Bienvenue, Enseignant !',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class BoutonSession extends StatefulWidget {
  const BoutonSession({super.key});

  @override
  State<BoutonSession> createState() => _BoutonSessionState();
}

class _BoutonSessionState extends State<BoutonSession> {
  bool _sessionOuverte = false; //variable pour gérer l'etat de la session
  void _toggleSession() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NavigationMenu()));
    setState(() {
      _sessionOuverte = !_sessionOuverte; //Change l'état
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleSession,
      child:
          Text(_sessionOuverte ? 'Terminer la session' : 'Démarrer la session'),
    );
  }
}

class LogingButton extends StatelessWidget {
  const LogingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => LogingScreen())),
        child: Text("Connexion"));
  }
}
