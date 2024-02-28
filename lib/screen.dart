import 'dart:convert';
import 'package:flutter/material.dart';
import 'Item.dart';

class JsonListViewScreen extends StatefulWidget {
  @override
  _JsonListViewScreenState createState() => _JsonListViewScreenState();
}

class _JsonListViewScreenState extends State<JsonListViewScreen> {
  late List<Item> items;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    try {
      // Carga el JSON desde el archivo assets
      String jsonString =
          await DefaultAssetBundle.of(context).loadString('assets/data.json');
      List<dynamic> jsonList = json.decode(jsonString);

      // Convierte el JSON en objetos Dart
      setState(() {
        items = jsonList.map((item) => Item.fromJson(item)).toList();
      });
    } catch (e) {
      print('Error cargando datos: $e');
      // Manejar el error según sea necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON ListView Example'),
        backgroundColor: const Color.fromARGB(255, 250, 129, 169), // Puedes cambiar el color de la barra de navegación aquí
      ),
      body: items != null
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.blueGrey[100], // Puedes cambiar el color del fondo de la tarjeta aquí
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      items[index].name,
                      style: TextStyle(
                        color: Colors.indigo[900], // Puedes cambiar el color del texto aquí
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'ID: ${items[index].id}',
                      style: TextStyle(
                        color: Colors.indigo[700], // Puedes cambiar el color del texto aquí
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              ),
            ),
    );
  }
}
