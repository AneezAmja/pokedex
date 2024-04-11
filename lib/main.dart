import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/poke_info.dart';
import 'package:test_app/pokedex.dart';
import 'dart:convert';

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
            return ListView.builder(
              itemCount: snapshot.data!.pokemon.length,
              itemBuilder: (context, index) {
                final poke = snapshot.data!.pokemon[index];
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PokeInfo(pokemon: poke),
                    ),
                  ),
                  child: Card(
                    color: Colors.red[100],
                    margin: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(poke.img),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "#${poke.id} - ${poke.name}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          children: poke.type
                              .map((type) => FilterChip(
                                    label: Text(type),
                                    onSelected: (b) {},
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
