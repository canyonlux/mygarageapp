import 'package:flutter/material.dart';
import 'package:mygarageapp/MenuPage.dart';

void main() {
  runApp(MyGarageApp());
}

class MyGarageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyGarageApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'roboto', // Cambiar la fuente si lo deseas
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false, // Quitar el banner de "Debug"
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo que cubre toda la pantalla
          Image.asset(
            'assets/garage.webp',
            fit: BoxFit.cover,
          ),
          // Superponer texto y botón sobre la imagen
          Column(
            children: <Widget>[
              Spacer(flex: 1), // Empuja el título más hacia arriba
              Text(
                'MYGARAGEAPP',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
              Spacer(flex: 3), // Espacio entre el título y el botón
              ElevatedButton.icon(
                onPressed: () {
                  // Navegar a la siguiente página (MenuPage)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuPage()),
                  );
                },
                icon: Icon(Icons.arrow_forward, size: 24), // Icono para invitar a entrar
                label: Text('Entrar'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey[800],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
              Spacer(flex: 1), // Espacio para empujar el botón hacia abajo
            ],
          ),
        ],
      ),
    );
  }
}
