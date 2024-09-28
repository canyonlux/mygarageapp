import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Necesario para JSON
import 'AddVehiclePage.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Map<String, String>> selectedVehicles = [];

  @override
  void initState() {
    super.initState();
    loadVehicles(); // Cargar los vehículos guardados al iniciar
  }

  // Método para guardar los vehículos en SharedPreferences
  Future<void> saveVehicles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedVehicles = jsonEncode(selectedVehicles); // Convertir la lista a JSON
    await prefs.setString('selectedVehicles', encodedVehicles);
  }

  // Método para cargar los vehículos desde SharedPreferences
  Future<void> loadVehicles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedVehicles = prefs.getString('selectedVehicles');
    if (encodedVehicles != null) {
      List<dynamic> decodedVehicles = jsonDecode(encodedVehicles);
      setState(() {
        selectedVehicles = decodedVehicles.map((vehicle) {
          return Map<String, String>.from(vehicle);
        }).toList();
      });
    }
  }

  // Método para agregar un vehículo a la lista
  void addVehicle(Map<String, String> vehicle) {
    setState(() {
      selectedVehicles.add(vehicle);
    });
    saveVehicles(); // Guardar los cambios
  }

  // Método para eliminar un vehículo de la lista
  void removeVehicle(int index) {
    setState(() {
      selectedVehicles.removeAt(index);
    });
    saveVehicles(); // Guardar los cambios
  }

  // Método para obtener el icono correspondiente
  Icon _getVehicleIcon(String type) {
    switch (type) {
      case 'Moto':
        return Icon(Icons.motorcycle, color: Colors.blueGrey[800]);
      case 'Bici':
        return Icon(Icons.directions_bike, color: Colors.blueGrey[800]);
      default:
        return Icon(Icons.directions_car, color: Colors.blueGrey[800]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tu Garaje'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/menupage.webp',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: selectedVehicles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white.withOpacity(0.8),
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: ListTile(
                        leading: _getVehicleIcon(selectedVehicles[index]['type']!),
                        title: Text(
                          selectedVehicles[index]['name']!,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                removeVehicle(index); // Llamar a eliminar vehículo
                              },
                            ),
                            Icon(Icons.more_vert, color: Colors.blueGrey[800]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          // Navegar a AddVehiclePage y esperar el resultado
                          Map<String, String>? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddVehiclePage(),
                            ),
                          );
                          if (result != null) {
                            addVehicle(result); // Agregar el vehículo seleccionado
                          }
                        },
                        icon: Icon(Icons.add),
                        label: Text('Agregar Vehículo'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[800],
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
