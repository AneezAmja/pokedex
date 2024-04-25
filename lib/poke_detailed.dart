import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:test_app/StatBar.dart';
import 'package:test_app/pokedex.dart';
import 'package:test_app/util/conversions.dart';
import 'package:test_app/util/extensions.dart';
import 'package:http/http.dart' as http;

class PokeInfo extends StatefulWidget {
  final Pokemon pokemon;

  const PokeInfo({super.key, required this.pokemon});

  @override
  State<PokeInfo> createState() => _PokeInfoState();
}

class _PokeInfoState extends State<PokeInfo> {
  PaletteGenerator? _paletteGenerator;
  bool _mounted = false;

  @override
  void initState() {
    super.initState();
    _mounted = true;

    _generatePalette();
    _fetchPokemonDescription();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  Future<void> _generatePalette() async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            NetworkImage(widget.pokemon.sprite));
    if (_mounted) {
      setState(() {
        _paletteGenerator = paletteGenerator;
      });
    }
  }

  Future<void> _fetchPokemonDescription() async {
    // Fetch description
    final response = await http.get(Uri.parse(
        "https://pokeapi.co/api/v2/pokemon-species/${widget.pokemon.id}/"));
    final decodedJSON = jsonDecode(response.body);
    final descriptions = decodedJSON['flavor_text_entries'];
    final englishDescription = descriptions.firstWhere(
      (entry) => entry['language']['name'] == 'en',
      orElse: () => {'flavor_text': 'No description available'},
    );
    final descriptionText = englishDescription != null
        ? englishDescription['flavor_text']
        : 'No description available';

    // Update Pokemon object with description
    setState(() {
      widget.pokemon.description = descriptionText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? bgColor = _paletteGenerator?.dominantColor?.color;
    final updatedDescriptionText =
        widget.pokemon.description.replaceAll('\n', ' ').replaceAll('\f', ' ');
    ; // API returns new line characters

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          /* Pokemon top portion with name, types */
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  (bgColor ?? Colors.teal[700]!).withOpacity(0.3),
                  bgColor ?? Colors.teal[700]!
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height / 3,
            child: Container(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.pokemon.name.capitalize(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Text(
                          "#${widget.pokemon.id.toString()}",
                          style: const TextStyle(
                            fontSize: 32,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: widget.pokemon.types
                        .map(
                          (type) => Container(
                            width: 60,
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 10.0,
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.0),
                              color: Colors.grey[300],
                            ),
                            child: Text(
                              type.name.capitalize(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
/*------------------------------------------------------------------------------------------------------------- */
          /* Description section */
          Positioned(
            top: (MediaQuery.of(context).size.height / 2) - 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.only(
                  top: 55.0, left: 30.0, right: 30.0, bottom: 30.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            updatedDescriptionText,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ]),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Weight: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Text(
                          '${widget.pokemon.weight / 10} kg / ${covertGramsIntoPounds(widget.pokemon.weight)} lbs',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Height: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Text(
                          '${widget.pokemon.height / 10} m / ${covertMetresIntoFeet(widget.pokemon.height)} ft',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Abilities: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        _getAbilities(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Stats",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                        _getBaseStats(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          /*------------------------------------------------------------------------------------------------------------- */
          /* Pokemon hero image */
          Hero(
            tag: widget.pokemon.sprite,
            child: Container(
              height: 190,
              width: 190,
              margin: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height / 3) - 90,
                left: (MediaQuery.of(context).size.width - 200) / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(widget.pokemon.sprite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAbilities() {
    return Wrap(
      spacing: 4.0,
      children: widget.pokemon.abilities
          .map(
            (ability) => Text(
              ability.name.capitalize(),
            ),
          )
          .toList(),
    );
  }

  Widget _getBaseStats() {
    final List<Widget> statBars = widget.pokemon.stats.map((stat) {
      return StatBar(
        label: stat.statName.capitalize(),
        value: stat.baseStat,
        barColour: _paletteGenerator?.lightVibrantColor?.color,
      );
    }).toList();

    final List<Widget> statRows = [];

    for (int i = 0; i < statBars.length; i += 2) {
      if (i + 1 < statBars.length) {
        statRows.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 30.0), // Adjust spacing as needed
              child: statBars[i],
            ),
            statBars[i + 1],
          ],
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: statRows,
    );
  }
}
