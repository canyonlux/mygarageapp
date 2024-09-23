import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart' as xml;

class AddVehiclePage extends StatefulWidget {
  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  String selectedVehicleType = 'Coche';
  List<String> vehicleList = [];

  // Método para cargar los vehículos desde el XML
  Future<void> loadVehicles(String type) async {
    try {
      final xmlString = await rootBundle.loadString('assets/vehiculos.xml');
      final document = xml.XmlDocument.parse(xmlString);
      final vehicles = document.findAllElements(type).map((node) => node.text).toList();

      setState(() {
        vehicleList = vehicles;
      });
    } catch (e) {
      print('Error al cargar o parsear el archivo XML: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadVehicles('Coche'); // Cargar coches por defecto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Vehículo'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _vehicleTypeButton('Coche', 'Coche'),
              _vehicleTypeButton('Moto', 'Moto'),
              _vehicleTypeButton('Bici', 'Bici'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: vehicleList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text(vehicleList[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Botón de selección de tipo de vehículo
  Widget _vehicleTypeButton(String type, String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedVehicleType = type;
        });
        loadVehicles(type);
      },
      style: ElevatedButton.styleFrom(
        primary: selectedVehicleType == type
            ? Colors.blueGrey[800]
            : Colors.blueGrey[300],
      ),
      child: Text(label),
    );
  }
}
