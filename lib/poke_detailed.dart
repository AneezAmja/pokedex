import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:test_app/StatBar.dart';
import 'package:test_app/pokedex.dart';

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

  @override
  Widget build(BuildContext context) {
    Color? bgColor = _paletteGenerator?.dominantColor?.color;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
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
              padding: const EdgeInsets.only(left: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pokemon.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
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
                              type.name,
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
          /* Description section */
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            left: 0,
            right: 0,
            bottom: 0,
            child:

                // SingleChildScrollView(
                //   child:

                Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.only(top: 55.0, left: 55.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 30.0),
                        child: Text(
                          'Weight: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Text(
                        '${widget.pokemon.weight} Kg',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 30.0),
                        child: Text(
                          'Height: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Text(
                        '${widget.pokemon.height} CM',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text(
                          'Type: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      _getAbilities(),
                    ],
                  ),
                  Row(
                    children: [
                      _getBaseStats(),
                    ],
                  )
                ],
              ),
            ),
            // ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 2) - 150,
            left: 0,
            right: 0,
            child: Hero(
              tag: widget.pokemon.sprite,
              child: Container(
                height: 250,
                width: 250,
                margin: const EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(widget.pokemon.sprite),
                  ),
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
              ability.name,
            ),
          )
          .toList(),
    );
  }

  Widget _getBaseStats() {
    return Column(children: [
      const Text(
        "Stats",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 22,
          fontFamily: 'Inter',
          fontWeight: FontWeight.bold,
          color: Colors.black45,
        ),
      ),
      const SizedBox(height: 20),
      Column(
        // spacing: 4.0,
        children: widget.pokemon.stats
            .map(
              (stat) => StatBar(
                  label: stat.statName,
                  value: stat.baseStat,
                  barColour: _paletteGenerator?.lightVibrantColor?.color),
            )
            .toList(),
      )
    ]);
  }
}
