import 'package:flutter/material.dart';
import 'package:mygarageapp/AddVehiclePage.dart';


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
          Image.asset(
            'assets/menupage.webp',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
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
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Pendiente implementar la página de mantenimiento
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
