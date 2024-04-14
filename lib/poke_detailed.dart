import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        // Use SingleChildScrollView for scrollable content
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: pokemon.img,
              child: Container(
                height: 200,
                width: 200,
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
            const SizedBox(height: 20.0), // Add spacing between widgets
            Text(
              "ID #${pokemon.id}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Align content horizontally
              children: [
                Text(
                  "Height: ${pokemon.height}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Weight: ${pokemon.weight}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Wrap(
              // Use Wrap for multi-line chip display
              spacing: 8.0,
              children: pokemon.type
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
  }
}
