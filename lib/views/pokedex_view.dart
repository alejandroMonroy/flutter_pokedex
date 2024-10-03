import 'package:flutter/material.dart';
import 'package:flutter_pokedex/controllers.dart/pokemons_controller.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/widgets/pokemon_list_item.dart';
import 'package:flutter_pokedex/widgets/pokemons_placeholder.dart';
import 'package:get/get.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({super.key});

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  bool _sortByName = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Filter by Pokemon type:'),
          ),
          const SizedBox(height: 8.0),
          GetBuilder<PokemonsController>(
            builder: (controller) {
              return SizedBox(
                height: 40.0,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return FilterChip(
                      label: Text(controller.filters[index]['name']),
                      avatar: Text('${controller.filters[index]['counter']}'),
                      selected: controller.filters[index]['isSelected'],
                      showCheckmark: false,
                      onSelected: (bool selected) {
                        controller
                            .enableFilter(controller.filters[index]['name']);
                      },
                    );
                  },
                  itemCount: controller.filters.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 8.0),
                ),
              );
            },
          ),
          const SizedBox(height: 16.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Sort pokemons by:'),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 40.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text('id'),
                    selected: !_sortByName,
                    showCheckmark: false,
                    avatar: !_sortByName
                        ? const Icon(Icons.arrow_downward_rounded)
                        : null,
                    onSelected: (bool selected) {
                      setState(() {
                        _sortByName = false;
                      });
                    },
                  ),
                  const SizedBox(width: 8.0),
                  ChoiceChip(
                    label: const Text('alphabetic'),
                    selected: _sortByName,
                    showCheckmark: false,
                    avatar: !_sortByName
                        ? null
                        : const Icon(Icons.arrow_downward_rounded),
                    onSelected: (bool selected) {
                      setState(() {
                        _sortByName = true;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<PokemonsController>(
              init: Get.put(PokemonsController()),
              builder: (controller) {
                final List<Pokemon> pokemons = controller.pokemonsInPokedex
                    .where((element) =>
                        controller.filters.firstWhereOrNull((filter) =>
                            filter['name'].toLowerCase() ==
                                element.typeNames.first.toLowerCase() &&
                            filter['isSelected'] == true) !=
                        null)
                    .toList();

                if (_sortByName) {
                  // alphabetical order:
                  pokemons.sort((a, b) =>
                      a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                } else {
                  // id order:
                  pokemons.sort((a, b) => a.pokemonId.compareTo(b.pokemonId));
                }

                if (pokemons.isEmpty) {
                  return const PokemonsPlaceholder();
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 24.0),
                  itemBuilder: (context, index) =>
                      PokemonListItem(pokemon: pokemons[index]),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: pokemons.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
