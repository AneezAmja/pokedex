import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/poke_detailed.dart';
import 'package:test_app/pokedex.dart';
import 'dart:convert';

import 'package:test_app/pokemon_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Pokedex App",
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Pokedex> pokedexFuture;

  @override
  void initState() {
    super.initState();
    pokedexFuture = fetchData();
  }

  Future<Pokedex> fetchData() async {
    final response = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"));
    final decodedJSON = jsonDecode(response.body);
    return Pokedex.fromJson(decodedJSON);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd03056),
        centerTitle: true,
        title: const Column(
          children: [
            Text("Pokedex"),
            Text(
              'Gotta catch em all!',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: FutureBuilder<Pokedex>(
        future: pokedexFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              children: snapshot.data!.pokemon
                  .map((poke) => PokemonCard(pokemon: poke))
                  .toList(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching data: ${snapshot.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
