import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mapView.dart';
export 'favoris.dart';
import 'package:http/http.dart' as http;

class FavorisList extends StatefulWidget {
  @override
  _FavorisListState createState() => _FavorisListState();
}

class _FavorisListState extends State<FavorisList> {
  // Mock data for testing
  List<Map<String, dynamic>> parkingData = [];
  List<String> favoris=[];

  @override
  void initState() {
    super.initState();
    recup ();
    fetchData();
  }
  Future<void>  recup () async {
    final prefs = await SharedPreferences.getInstance();
    favoris = prefs.getStringList('listFavoris') as List<String>;
  }
  Color setupColor(int dispo, int max){
    if (dispo/max>=0.6)
      return Colors.green;
    if (dispo/max>=0.15)
      return Colors.orange;
    else
      return Colors.redAccent;

  }
  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'http://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/disponibilite-parkings/records?where=etat%3D%22OUVERT%22&order_by=dispo%20DESC&limit=-1'),
    );

    if (response.statusCode == 200) {
      // Si la requête est réussie, parsez le JSON
      final jsonData = json.decode(response.body);
      setState(() {
        parkingData = List.from(jsonData['results']);
      });
    } else {
      // Si la requête a échoué, affichez une erreur dans la console
      print('Échec de la requête GET avec le statut : ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Favoris',style: TextStyle(
          color: Colors.purple,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: ListView.builder(

        itemCount: parkingData.length,
        itemBuilder: (context, index) {
          print("hhhhhhhhhhhhhhhhhhhhhhh$favoris");
    return Card(
    child: ListTile(
    title: Text(parkingData[index]['libelle']),
    subtitle: Text(parkingData[index]['adresse']),
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => MapView(parkingData[index]),
    ),
    );
    },
    trailing: CircleAvatar(
    radius : 10,
    backgroundColor: setupColor(parkingData[index]['dispo'],parkingData[index]['max']), // Change color as needed
    ),
    ),
    );
       }
      ),
    );
  }
}
