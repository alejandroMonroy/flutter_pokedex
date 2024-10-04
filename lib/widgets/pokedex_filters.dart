import 'package:flutter/material.dart';
import 'package:flutter_pokedex/controllers.dart/pokemons_controller.dart';
import 'package:get/get.dart';

class PokedexFilters extends StatelessWidget {
  const PokedexFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonsController>(
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
                  controller.enableFilter(controller.filters[index]['name']);
                },
              );
            },
            itemCount: controller.filters.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 8.0),
          ),
        );
      },
    );
  }
}
