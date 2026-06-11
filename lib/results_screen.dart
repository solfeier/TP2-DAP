import 'package:flutter/material.dart';

import 'models.dart';

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ResultsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Product masCaro = data['masCaro'] as Product;
    final Product masBarato = data['masBarato'] as Product;
    final Product mayorCantidad = data['mayorCantidad'] as Product;
    final Product menorCantidad = data['menorCantidad'] as Product;
    final double promedio = data['promedio'] as double;

    return Scaffold(
      appBar: AppBar(title: const Text("Resultados")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Resultados del Análisis:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("Producto más caro:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Nombre: ${masCaro.name} - Descripción: ${masCaro.description}"),
            const SizedBox(height: 15),
            const Text("Producto más barato:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Nombre: ${masBarato.name} - Descripción: ${masBarato.description}"),
            const SizedBox(height: 15),
            const Text("Mayor cantidad:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Nombre: ${mayorCantidad.name} - Descripción: ${mayorCantidad.description}"),
            const SizedBox(height: 15),
            const Text("Menor cantidad:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Nombre: ${menorCantidad.name} - Descripción: ${menorCantidad.description}"),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              "Precio promedio total: \$${promedio.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}