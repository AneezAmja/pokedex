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
  final String num;
  final String name;
  final String img;
  final List<String> type;
  final String height;
  final String weight;
  final String candy;
  final int? candyCount;
  final String egg;
  final String spawnChance;
  final String avgSpawns;
  final String spawnTime;
  final List<double>? multipliers;
  final List<String> weaknesses;
  final List<NextEvolution>? nextEvolution;

  Pokemon({
    required this.id,
    required this.num,
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    this.candyCount,
    required this.egg,
    required this.spawnChance,
    required this.avgSpawns,
    required this.spawnTime,
    this.multipliers,
    required this.weaknesses,
    this.nextEvolution,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      num: json['num'],
      name: json['name'],
      img: json['img'],
      type: json['type'].cast<String>(),
      height: json['height'],
      weight: json['weight'],
      candy: json['candy'],
      candyCount: json['candy_count'] ?? 0,
      egg: json['egg'],
      spawnChance: json['spawn_chance'].toString(),
      avgSpawns: json['avg_spawns'].toString(),
      spawnTime: json['spawn_time'],
      multipliers: json['multipliers']?.cast<double>(),
      weaknesses: json['weaknesses'].cast<String>(),
      nextEvolution: json['next_evolution'] != null
          ? (json['next_evolution'] as List)
              .map((v) => NextEvolution.fromJson(v))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'num': num,
      'name': name,
      'img': img,
      'type': type,
      'height': height,
      'weight': weight,
      'candy': candy,
      'candy_count': candyCount,
      'egg': egg,
      'spawn_chance': spawnChance,
      'avg_spawns': avgSpawns,
      'spawn_time': spawnTime,
      'multipliers': multipliers,
      'weaknesses': weaknesses,
      'next_evolution': nextEvolution?.map((v) => v.toJson()).toList(),
    };
  }
}

class NextEvolution {
  final String num;
  final String name;

  NextEvolution({required this.num, required this.name});

  factory NextEvolution.fromJson(Map<String, dynamic> json) {
    return NextEvolution(
      num: json['num'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'num': num,
      'name': name,
    };
  }
}
