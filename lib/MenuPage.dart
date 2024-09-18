import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final List<String> vehiculos = ['Coche 1', 'Moto 2', 'Bicicleta 3'];

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
          // Imagen de fondo
          Image.asset(
            'assets/menupage.webp',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              // Lista de vehículos en la parte superior
              Expanded(
                child: ListView.builder(
                  itemCount: vehiculos.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white.withOpacity(0.8),
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: ListTile(
                        leading: Icon(Icons.directions_car, color: Colors.blueGrey[800]),
                        title: Text(
                          vehiculos[index],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        trailing: Icon(Icons.more_vert, color: Colors.blueGrey[800]),
                        onTap: () {
                          // Acción al seleccionar un vehículo
                        },
                      ),
                    );
                  },
                ),
              ),
              // Botones en la parte inferior
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botón para agregar vehículo
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navegar a la página para agregar un vehículo
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddVehiclePage()),
                          );
                        },
                        icon: Icon(Icons.add),
                        label: Text('Agregar Vehículo'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[800],
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                      ),
                    ),
                    SizedBox(width: 20), // Espacio entre los botones
                    // Botón para registrar mantenimiento
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navegar a la página de registrar mantenimiento
                        },
                        icon: Icon(Icons.build),
                        label: Text('Registrar Mantenimiento'),
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

// Página para agregar un vehículo
class AddVehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Vehículo'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Center(
        child: Text(
          'Formulario para agregar vehículo',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}