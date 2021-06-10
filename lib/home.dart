import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtCep = new TextEditingController();
  String results = "";

  _consultCep() async {
    String cep = txtCep.text;
    String url = "https://viacep.com.br/ws/$cep/json/";
    http.Response response;
    response = await http.get(Uri.parse(url));

    Map<String, dynamic> httpResponse = json.decode(response.body);
    
    String city = httpResponse["localidade"];
    String state = httpResponse["uf"];
    String street = httpResponse["logradouro"];
    String neighborwood = httpResponse["bairro"];

    setState(() {
      results = "$street, $neighborwood - $city/$state";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulte CEP"), 
        backgroundColor: Colors.purple,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Insira o CEP"
              ),
              style: TextStyle(fontSize: 15),
              controller: txtCep,
            ),
            Text(
              results, 
              style: TextStyle(fontSize: 25),
            ),
            ElevatedButton(
              onPressed: () => _consultCep(), 
              child: Text("Buscar"),
            ),
          ],
        ),
      ),
    );
  }
}
