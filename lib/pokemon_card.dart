import 'package:flutter/material.dart';
import 'package:test_app/poke_detailed.dart';
import 'package:test_app/pokedex.dart';

class PokemonCard extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonCard({required this.pokemon});

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokeInfo(pokemon: widget.pokemon),
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
                  image: NetworkImage(widget.pokemon.img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Text(
                "#${widget.pokemon.id} - ${widget.pokemon.name}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: widget.pokemon.type
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
