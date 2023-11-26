import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'mapView.dart';
import 'package:http/http.dart' as http;


class ParkingList extends StatefulWidget {
  List<String> favorisData = [];

  @override
  _ParkingListState createState() => _ParkingListState();
}

class _ParkingListState extends State<ParkingList> {
  // Mock data for testing
  List<Map<String, dynamic>> parkingData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
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
  Future<void>  stok(int index) async {
    print("added");
    final prefs = await SharedPreferences.getInstance();
// set value
    widget.favorisData.add(index as String)  ;
    prefs.setStringList('listFavoris',widget.favorisData as List<String>);
  }
  Future<void> destok(int index) async {
    print("deleted");
    final prefs = await SharedPreferences.getInstance();
// set value
    widget.favorisData.remove(index as String)  ;
    prefs.setStringList('listFavoris',widget.favorisData as List<String>);
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Parkings disponibles', style: TextStyle(
            color: Colors.purple,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        body: ListView.builder(
          itemCount: parkingData.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(parkingData[index]['libelle']),
                subtitle: Text(parkingData[index]['adresse']),
                onLongPress: ()=>{
            if (widget.favorisData.contains(index)){
            destok(index)
            }
            else{
            stok(index)
            }},
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
          },
        ),
      );
    }
  }
