// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
    final response = await http
        .get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=151"));
    final decodedJSON = jsonDecode(response.body);

    List<Pokemon> pokemonList = [];

    for (var pokemonData in decodedJSON['results']) {
      final pokemonResponse = await http.get(Uri.parse(pokemonData['url']));
      final pokemonJSON = jsonDecode(pokemonResponse.body);

      // Creating pokemon object from the pased JSON response
      Pokemon pokemon = Pokemon.fromJson(pokemonJSON);
      pokemonList.add(pokemon);
    }

    return Pokedex(pokemon: pokemonList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffefeff1),
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              "Pokedex",
              style:
                  TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
            ),
            Text(
              'Gotta catch em all!',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xffefeff1),
        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: FutureBuilder<Pokedex>(
          future: pokedexFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0, // Spacing between col
                mainAxisSpacing: 8.0, // Spacing between rows
                childAspectRatio: 5 / 4,
                shrinkWrap: true,
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
      ),
    );
  }
}
