class Pokedex {
  final List<Pokemon> pokemon;

  Pokedex({required this.pokemon});

  factory Pokedex.fromJson(Map<String, dynamic> json) {
    return Pokedex(
      pokemon: json['pokemon'] != null
          ? (json['pokemon'] as List).map((v) => Pokemon.fromJson(v)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pokemon': pokemon.map((v) => v.toJson()).toList(),
    };
  }
}

class Pokemon {
  final int id;
  final String name;
  final int height;
  final int weight;
  final String sprite;
  final List<PokemonAbility> abilities;
  final List<PokemonType> types;
  final List<PokemonStat> stats;
  String description;

  Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.sprite,
    required this.abilities,
    required this.types,
    required this.stats,
    this.description = '',
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<dynamic> typesJson = json['types'];
    List<PokemonType> parsedTypes = typesJson.map((typeJson) {
      return PokemonType.fromJson(typeJson['type']);
    }).toList();

    List<dynamic> abilitiesJson = json['abilities'];
    List<PokemonAbility> parsedAbilities = abilitiesJson.map((abilityJson) {
      return PokemonAbility.fromJson(abilityJson['ability']);
    }).toList();

    List<dynamic> statsJson = json['stats'];
    List<PokemonStat> parsedStats = (statsJson).map((statJson) {
      return PokemonStat.fromJson(statJson);
    }).toList();

    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      sprite: json['sprites']['front_default'],
      abilities: parsedAbilities,
      types: parsedTypes,
      stats: parsedStats,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'sprite': sprite,
      'abilities': abilities,
      'types': types,
      'stats': stats,
    };
  }
}

class PokemonType {
  final String name;

  PokemonType({
    required this.name,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      name: json['name'],
    );
  }
}

class PokemonAbility {
  final String name;

  PokemonAbility({
    required this.name,
  });

  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(
      name: json['name'],
    );
  }
}

class PokemonStat {
  final int baseStat;
  final String statName;
  PokemonStat({
    required this.baseStat,
    required this.statName,
  });

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      baseStat: json['base_stat'],
      statName: json['stat']['name'],
    );
  }
}
