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
  // Controladores para la información del vehículo
  final TextEditingController _kilometrosController = TextEditingController();
  final TextEditingController _anioFabricacionController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _proximaItvController = TextEditingController();
  final TextEditingController _operacionesController = TextEditingController();

  // Controladores para el formulario de mantenimiento
  final TextEditingController _mantenimientoDateController = TextEditingController();
  final TextEditingController _mantenimientoOperacionesController = TextEditingController();
  final TextEditingController _mantenimientoPiezasController = TextEditingController();
  final TextEditingController _mantenimientoPrecioController = TextEditingController();

  List<Map<String, String>> mantenimientos = [];

  @override
  void initState() {
    super.initState();
    loadVehicleData(); // Cargar datos del vehículo
    loadMantenimientos(); // Cargar mantenimientos
  }

  // Método para cargar los datos del vehículo desde SharedPreferences
  Future<void> loadVehicleData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _kilometrosController.text = prefs.getString('kilometros_${widget.vehicle['name']}') ?? '';
      _anioFabricacionController.text = prefs.getString('anio_fabricacion_${widget.vehicle['name']}') ?? '';
      _colorController.text = prefs.getString('color_${widget.vehicle['name']}') ?? '';
      _matriculaController.text = prefs.getString('matricula_${widget.vehicle['name']}') ?? '';
      _proximaItvController.text = prefs.getString('proxima_itv_${widget.vehicle['name']}') ?? '';
      _operacionesController.text = prefs.getString('operaciones_${widget.vehicle['name']}') ?? '';
    });
  }

  // Método para guardar los datos del vehículo en SharedPreferences
  Future<void> saveVehicleData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('kilometros_${widget.vehicle['name']}', _kilometrosController.text);
    await prefs.setString('anio_fabricacion_${widget.vehicle['name']}', _anioFabricacionController.text);
    await prefs.setString('color_${widget.vehicle['name']}', _colorController.text);
    await prefs.setString('matricula_${widget.vehicle['name']}', _matriculaController.text);
    await prefs.setString('proxima_itv_${widget.vehicle['name']}', _proximaItvController.text);
    await prefs.setString('operaciones_${widget.vehicle['name']}', _operacionesController.text);
  }

  // Método para guardar el mantenimiento
  void saveMantenimiento() {
    if (_mantenimientoDateController.text.isNotEmpty &&
        _mantenimientoOperacionesController.text.isNotEmpty &&
        _mantenimientoPiezasController.text.isNotEmpty &&
        _mantenimientoPrecioController.text.isNotEmpty) {
      setState(() {
        mantenimientos.add({
          'fecha': _mantenimientoDateController.text,
          'operaciones': _mantenimientoOperacionesController.text,
          'piezas': _mantenimientoPiezasController.text,
          'precio': _mantenimientoPrecioController.text,
        });
      });

      // Guardar mantenimientos en SharedPreferences
      saveMantenimientos();

      // Limpiar los campos después de guardar
      _mantenimientoDateController.clear();
      _mantenimientoOperacionesController.clear();
      _mantenimientoPiezasController.clear();
      _mantenimientoPrecioController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }

  // Método para guardar mantenimientos en SharedPreferences
  Future<void> saveMantenimientos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'mantenimientos_${widget.vehicle['name']}';
    String encodedMantenimientos = jsonEncode(mantenimientos);
    await prefs.setString(key, encodedMantenimientos);
  }

  // Método para cargar mantenimientos desde SharedPreferences
  Future<void> loadMantenimientos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'mantenimientos_${widget.vehicle['name']}';
    String? encodedMantenimientos = prefs.getString(key);
    if (encodedMantenimientos != null) {
      List<dynamic> decodedMantenimientos = jsonDecode(encodedMantenimientos);
      setState(() {
        mantenimientos = decodedMantenimientos.cast<Map<String, String>>();
      });
    }
  }

  // Método para obtener la imagen del vehículo
  String _getVehicleImage(String type) {
    switch (type) {
      case 'Coche':
        return 'assets/coche.jpeg';
      case 'Moto':
        return 'assets/moto.jpeg';
      case 'Bici':
        return 'assets/bici.jpeg';
      default:
        return 'assets/default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle['name']!),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                _getVehicleImage(widget.vehicle['type']!),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),

              // Formulario editable para la información del vehículo
              TextField(
                controller: _kilometrosController,
                decoration: InputDecoration(labelText: 'Kilómetros'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _anioFabricacionController,
                decoration: InputDecoration(labelText: 'Año de Fabricación'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _colorController,
                decoration: InputDecoration(labelText: 'Color'),
              ),
              TextField(
                controller: _matriculaController,
                decoration: InputDecoration(labelText: 'Matrícula'),
              ),
              TextField(
                controller: _proximaItvController,
                decoration: InputDecoration(labelText: 'Próxima ITV'),
              ),
              TextField(
                controller: _operacionesController,
                decoration: InputDecoration(labelText: 'Operaciones a Realizar'),
              ),
              ElevatedButton(
                onPressed: saveVehicleData,
                child: Text('Guardar Datos del Vehículo'),
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey[800]),
              ),
              SizedBox(height: 16),

              // Formulario para añadir mantenimiento
              TextField(
                controller: _mantenimientoDateController,
                decoration: InputDecoration(labelText: 'Fecha de Mantenimiento'),
              ),
              TextField(
                controller: _mantenimientoOperacionesController,
                decoration: InputDecoration(labelText: 'Operaciones Realizadas'),
              ),
              TextField(
                controller: _mantenimientoPiezasController,
                decoration: InputDecoration(labelText: 'Piezas Sustituidas'),
              ),
              TextField(
                controller: _mantenimientoPrecioController,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: saveMantenimiento,
                child: Text('Grabar Mantenimiento'),
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey[800]),
              ),
              SizedBox(height: 16),

              // Listado de mantenimientos realizados
              Text(
                'Mantenimientos Realizados:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true, // Permitir que la lista se ajuste a su contenido
                physics: NeverScrollableScrollPhysics(), // Desactivar el scroll de la lista
                itemCount: mantenimientos.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Fecha: ${mantenimientos[index]['fecha']}'),
                      subtitle: Text(
                          'Operaciones: ${mantenimientos[index]['operaciones']} - Piezas: ${mantenimientos[index]['piezas']} - Precio: ${mantenimientos[index]['precio']}'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
