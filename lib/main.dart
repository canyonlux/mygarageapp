import 'package:flutter/material.dart';

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
        fontFamily: 'Roboto', // Cambiar la fuente si lo deseas
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
              ElevatedButton(
                onPressed: () {
                  // Navegar a la siguiente página
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text('Entrar'),
              ),
              Spacer(flex:1), // Espacio para empujar el botón hacia abajo
            ],
          ),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Siguiente Página'),
      ),
      body: Center(
        child: Text(
          'Esta es la siguiente página',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
