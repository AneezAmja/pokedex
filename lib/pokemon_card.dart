import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:test_app/poke_detailed.dart';
import 'package:test_app/pokedex.dart';

class PokemonCard extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  PaletteGenerator? _paletteGenerator;

  @override
  void initState() {
    super.initState();
    _generatePalette();
  }

  Future<void> _generatePalette() async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            NetworkImage(widget.pokemon.img));
    setState(() {
      _paletteGenerator = paletteGenerator;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? bgColor = _paletteGenerator?.dominantColor?.color;
    return Card(
      color: bgColor ?? const Color(0xffcddaef),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokeInfo(pokemon: widget.pokemon),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ROW FOR NAME
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                    child: Text(
                      widget.pokemon.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        color: Color(0xffefeff1),
                        shadows: [
                          Shadow(
                            offset: Offset(0, 2.0),
                            blurRadius: 5.0,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 8.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: widget.pokemon.type
                            .map(
                              (type) => Container(
                                  width: 60,
                                  margin: const EdgeInsets.only(bottom: 4),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 1.0, sigmaY: 1.0),
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 3.0, 0, 3.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              border: Border.all(
                                                color: Colors.grey[400]!
                                                    .withOpacity(
                                                        0.2), // Outline color
                                                width: 1.0, // Outline width
                                              ),
                                              color: Colors.grey[400]
                                                  ?.withOpacity(0.4),
                                            ),
                                            child: Center(
                                              child: Text(
                                                type,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffefeff1),
                                                ),
                                              ),
                                            ),
                                          )))),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      width: 75.0,
                      height: 75.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.pokemon.img),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
