import 'package:flutter/material.dart';

import '../models.dart';
import '../rutas.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  Product? productoMasCaro;
  Product? productoMasBarato;
  Product? productoMayorCantidad;
  Product? productoMenorCantidad;

  double sumaPrecios = 0.0;
  int totalProductos = 0;

  void ingresarProducto() {
    setState(() {
      String nombre = nombreController.text;
      String descripcion = descripcionController.text;
      double? precio = double.tryParse(precioController.text);
      int? cantidad = int.tryParse(cantidadController.text);

      if (nombre.isEmpty || descripcion.isEmpty || precio == null || cantidad == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Complete todos los campos de forma correcta")),
        );
        return;
      }

      Product nuevo = Product(name: nombre, description: descripcion, price: precio, quantity: cantidad);

      // Si es el primer producto cargado
      if (totalProductos == 0) {
        productoMasCaro = nuevo;
        productoMasBarato = nuevo;
        productoMayorCantidad = nuevo;
        productoMenorCantidad = nuevo;
      } else {
        // Validaciones en tiempo real
        if (nuevo.price > productoMasCaro!.price) productoMasCaro = nuevo;
        if (nuevo.price < productoMasBarato!.price) productoMasBarato = nuevo;
        if (nuevo.quantity > productoMayorCantidad!.quantity) productoMayorCantidad = nuevo;
        if (nuevo.quantity < productoMenorCantidad!.quantity) productoMenorCantidad = nuevo;
      }

      sumaPrecios += nuevo.price;
      totalProductos++;

      // Limpieza de campos
      nombreController.clear();
      descripcionController.clear();
      precioController.clear();
      cantidadController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Producto ingresado con éxito")),
      );
    });
  }

  void calcularResultados() {
    if (totalProductos == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Debe ingresar al menos un producto antes de calcular")),
      );
      return;
    }

    double promedio = sumaPrecios / totalProductos;

    // Enviamos los datos procesados mediante un mapa
    appRoutes.push('/results', extra: {
      'masCaro': productoMasCaro,
      'masBarato': productoMasBarato,
      'mayorCantidad': productoMayorCantidad,
      'menorCantidad': productoMenorCantidad,
      'promedio': promedio,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 179, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Carga de Productos",
                style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(controller: nombreController, decoration: const InputDecoration(labelText: "Nombre")),
              TextField(controller: descripcionController, decoration: const InputDecoration(labelText: "Descripción")),
              TextField(controller: precioController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Precio")),
              TextField(controller: cantidadController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Cantidad")),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: ingresarProducto,
                child: const Text("Ingresar producto"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: calcularResultados,
                child: const Text("Calcular"),
              ),
              const SizedBox(height: 20),
              Text(
                "Productos cargados: $totalProductos",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
