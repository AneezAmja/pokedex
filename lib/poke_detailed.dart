import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_app/pokedex.dart';

class PokeInfo extends StatelessWidget {
  final Pokemon pokemon;

  const PokeInfo({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(pokemon.name),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          // Use SingleChildScrollView for scrollable content
          padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: pokemon.img,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // Add rounded corners
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(pokemon.img),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "ID #${pokemon.num}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Height: ${pokemon.height}",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10.0),
              Text(
                "Weight: ${pokemon.weight}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Weakness: ",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: pokemon.weaknesses
                        .map(
                          (type) => Container(
                            width: 60,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 10.0),
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.0),
                              color: Colors.grey[300],
                            ),
                            child: Text(
                              type,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                "Next Evolution: ${pokemon.nextEvolution != null ? pokemon.nextEvolution!.map((evolution) => evolution.name).join(', ') : 'None'}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Type: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: pokemon.type
                        .map(
                          (type) => Container(
                            width: 60,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 10.0),
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.0),
                              color: Colors.grey[300],
                            ),
                            child: Text(
                              type,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
