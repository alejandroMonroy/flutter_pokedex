import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/pokemon_colors.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/widgets/save_pokemon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PokemonView extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonView({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  color: Color(pokemoncolors.firstWhere((element) =>
                          element['name'] == pokemon.typeNames.first)['color']
                      as int),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        bottom: -40,
                        left: -40,
                        right: -40,
                        top: -40,
                        child: SvgPicture.network(
                          pokemon.imageUrl,
                          fit: BoxFit.contain,
                          colorFilter: const ColorFilter.mode(
                            Colors.black26,
                            BlendMode.modulate,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 0,
                        child: SvgPicture.network(
                          pokemon.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 80.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${pokemon.height}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text('Height'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${pokemon.pokemonId}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text('Nº'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${pokemon.weight}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text('Weight'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16.0,
                        left: 8.0,
                        right: 8.0,
                        child: SizedBox(
                          height: 96.0,
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: Colors.white,
                                        size: 16.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        pokemon.typeNames.first.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    SavePokemonButton(pokemon: pokemon),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  pokemon.name.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 16.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
