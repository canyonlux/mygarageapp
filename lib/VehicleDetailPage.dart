import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Necesario para JSON

class VehicleDetailPage extends StatefulWidget {
  final Map<String, String> vehicle;

  VehicleDetailPage({required this.vehicle});

  @override
  _VehicleDetailPageState createState() => _VehicleDetailPageState();
}

class _VehicleDetailPageState extends State<VehicleDetailPage> {
  final TextEditingController _mantenimientoDateController = TextEditingController();
  final TextEditingController _operacionesController = TextEditingController();
  final TextEditingController _piezasController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  List<Map<String, String>> mantenimientos = [];

  @override
  void initState() {
    super.initState();
    loadMantenimientos(); // Cargar mantenimientos al iniciar
  }

  // Método para guardar el mantenimiento
  void saveMantenimiento() {
    if (_mantenimientoDateController.text.isNotEmpty &&
        _operacionesController.text.isNotEmpty &&
        _piezasController.text.isNotEmpty &&
        _precioController.text.isNotEmpty) {
      setState(() {
        mantenimientos.add({
          'fecha': _mantenimientoDateController.text,
          'operaciones': _operacionesController.text,
          'piezas': _piezasController.text,
          'precio': _precioController.text,
        });
      });

      // Guardar mantenimientos en SharedPreferences
      saveMantenimientos();

      // Limpiar los campos después de guardar
      _mantenimientoDateController.clear();
      _operacionesController.clear();
      _piezasController.clear();
      _precioController.clear();
    } else {
      // Mostrar un mensaje de error si hay campos vacíos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }

  // Método para guardar mantenimientos en SharedPreferences
  Future<void> saveMantenimientos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'mantenimientos_${widget.vehicle['name']}'; // Usar el nombre del vehículo como clave
    String encodedMantenimientos = jsonEncode(mantenimientos); // Convertir la lista a JSON
    await prefs.setString(key, encodedMantenimientos);
  }

  // Método para cargar mantenimientos desde SharedPreferences
  Future<void> loadMantenimientos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'mantenimientos_${widget.vehicle['name']}'; // Usar el nombre del vehículo como clave
    String? encodedMantenimientos = prefs.getString(key);
    if (encodedMantenimientos != null) {
      List<dynamic> decodedMantenimientos = jsonDecode(encodedMantenimientos);
      setState(() {
        mantenimientos = decodedMantenimientos.cast<Map<String, String>>();
      });
    }
  }

  // Método para obtener la imagen del vehículo según su tipo
  String _getVehicleImage(String type) {
    switch (type) {
      case 'Coche':
        return 'assets/coche.png'; // Cambia la ruta según tu estructura de carpetas
      case 'Moto':
        return 'assets/moto.png';
      case 'Bici':
        return 'assets/bici.png';
      default:
        return 'assets/default.png'; // Imagen por defecto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle['name']!),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del vehículo
            Image.asset(
              _getVehicleImage(widget.vehicle['type']!),
              height: 200,
            ),
            SizedBox(height: 16),

            // Descripción del vehículo
            Text(
              'Descripción:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Kilómetros: ${widget.vehicle['kilometros']}'),
            Text('Año de fabricación: ${widget.vehicle['anio_fabricacion']}'),
            Text('Color: ${widget.vehicle['color']}'),
            Text('Matrícula: ${widget.vehicle['matricula']}'),
            Text('Próxima ITV: ${widget.vehicle['proxima_itv']}'),
            Text('Operaciones a realizar: ${widget.vehicle['operaciones']}'),
            SizedBox(height: 16),

            // Formulario de mantenimiento
            Text(
              'Añadir Mantenimiento:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _mantenimientoDateController,
              decoration: InputDecoration(labelText: 'Fecha de Mantenimiento'),
            ),
            TextField(
              controller: _operacionesController,
              decoration: InputDecoration(labelText: 'Operaciones Realizadas'),
            ),
            TextField(
              controller: _piezasController,
              decoration: InputDecoration(labelText: 'Piezas Sustituidas'),
            ),
            TextField(
              controller: _precioController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: saveMantenimiento,
              child: Text('Grabar Mantenimiento'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 16),

            // Listado de mantenimientos realizados
            Text(
              'Mantenimientos Realizados:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: mantenimientos.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text('Fecha: ${mantenimientos[index]['fecha']}'),
                      subtitle: Text(
                          'Operaciones: ${mantenimientos[index]['operaciones']} - Piezas: ${mantenimientos[index]['piezas']} - Precio: ${mantenimientos[index]['precio']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
