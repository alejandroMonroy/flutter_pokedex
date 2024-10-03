import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/pokemon_colors.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/services/pokeapi_service.dart';
import 'package:flutter_pokedex/services/sqflite_service.dart';
import 'package:get/get.dart';

class PokemonsController extends GetxController {
  List<Pokemon> pokemons = [];
  List<Pokemon> pokemonsInPokedex = [];
  TextEditingController pokemonsSearchController = TextEditingController();
  bool isLoadingPokemons = false;
  List<Map<String, dynamic>> filters = [];

  static PokemonsController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    initializeFilters();
    getAllPokemons();
    getPokedex();
  }

  initializeFilters() {
    filters = List.from(pokemoncolors
        .map((filter) => {...filter, 'isSelected': false, 'counter': 0}));
    update();
  }

  updateTheme() {
    Get.changeTheme(
      ThemeData(
        colorSchemeSeed: filters.first['counter'] > 0 &&
                filters.first['counter'] > filters[1]['counter']
            ? Color(filters.first['color'])
            : Colors.red,
        useMaterial3: true,
      ),
    );
  }

  updateFilters() {
    List<Map<String, dynamic>> filters = [];

    for (var filter in this.filters) {
      final int counter = pokemonsInPokedex
          .where((pokemon) =>
              pokemon.typeNames.first.toLowerCase() == filter['name'])
          .length;
      filters.add(
        {
          ...filter,
          'isSelected': counter > 0,
          'counter': counter,
        },
      );
    }

    filters.sort((a, b) => b['counter'].compareTo(a['counter']));
    this.filters = filters;
    updateTheme();
    update();
  }

  disableAllFilters() {
    for (var filter in filters) {
      filter['isSelected'] = false;
    }
    update();
  }

  enableFilter(String name) {
    final int index = filters.indexWhere((filter) => filter['name'] == name);
    if (index >= 0) {
      filters[index] = {
        ...filters[index],
        'isSelected': !filters[index]['isSelected'],
      };
    }

    update();
  }

  Future<void> getPokedex() async {
    final List<Map<String, dynamic>> result =
        await SqfliteService.retrieveFromPokedex();
    pokemonsInPokedex = List<Pokemon>.from(
        result.map((element) => Pokemon.fromDatabase(Map.from(element))));
    updateFilters();
    update();
  }

  Future<void> savePokemon(Pokemon pokemon) async {
    await SqfliteService.insert(
      'pokedex',
      {'pokemonId': pokemon.pokemonId},
    );
    pokemonsInPokedex.add(pokemon);
    updateFilters();
    update();
  }

  Future<void> removePokemon(Pokemon pokemon) async {
    await SqfliteService.remove(
      'pokedex',
      {'pokemonId': pokemon.pokemonId},
    );
    pokemonsInPokedex.removeWhere((e) => e.pokemonId == pokemon.pokemonId);
    pokemonsSearchController.clear();
    searchPokemons('');
    updateFilters();
    update();
  }

  Future<void> searchPokemons(String query) async {
    final List<Map<String, Object?>> data = await SqfliteService.retrieve(
      'pokemons',
      pokemonsSearchController.text,
    );
    List<Pokemon> pokemons =
        data.map((element) => Pokemon.fromDatabase(Map.from(element))).toList();

    this.pokemons = pokemons;
    update();
  }

  Future<void> getAllPokemons({bool mustRefetch = false}) async {
    if (!mustRefetch) {
      isLoadingPokemons = true;
      update();
    }

    final List<Map<String, Object?>> data = await SqfliteService.retrieve(
      'pokemons',
      '',
    );
    List<Pokemon> pokemons =
        data.map((element) => Pokemon.fromDatabase(Map.from(element))).toList();

    if (pokemons.isEmpty || mustRefetch) {
      try {
        pokemons.clear();
        await SqfliteService.clearTable('pokemons');
        final PokeApiListResponse pokeApiResponse =
            await PokeApiService.fetchPokemons();

        final List<String> pokemonUrls = List<String>.from(
            pokeApiResponse.results.map((element) => element['url']));

        for (var url in pokemonUrls) {
          final Map<String, dynamic> result =
              await PokeApiService.fetchPokemonByUrl(url);
          final Pokemon pokemon = Pokemon.fromMap(result);
          await SqfliteService.insert('pokemons', pokemon.toMap());
          pokemons.add(pokemon);
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }

    this.pokemons = pokemons;
    isLoadingPokemons = false;
    update();
  }
}
