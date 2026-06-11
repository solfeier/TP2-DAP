import 'package:flutter/material.dart';

import '../models.dart';
import '../rutas.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usuarioController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String mensaje = "";

  // Usuario hardcodeado usando la clase User
  final User usuarioValido = User(username: "solort", password: "meca123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 183, 213),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              TextField(
                controller: usuarioController,
                decoration: const InputDecoration(labelText: "Usuario"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Contraseña"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    String usuario = usuarioController.text;
                    String password = passwordController.text;
                    if (usuario.isEmpty || password.isEmpty) {
                      mensaje = "Complete todos los campos";
                    } else if (usuario == usuarioValido.username && password == usuarioValido.password) {
                      mensaje = "Login correcto";
                      appRoutes.push('/home');
                    } else {
                      mensaje = "Usuario o contraseña incorrectos";
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(mensaje)),
                    );
                  });
                },
                child: const Text("Ingresar"),
              ),
              const SizedBox(height: 20),
              Text(
                mensaje,
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}