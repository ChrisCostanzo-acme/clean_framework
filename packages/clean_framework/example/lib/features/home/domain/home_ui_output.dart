import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_example/features/home/domain/home_entity.dart';
import 'package:clean_framework_example/features/home/models/pokemon_model.dart';

class HomeUIOutput extends Output {
  HomeUIOutput({
    required this.pokemons,
    required this.status,
    required this.isRefresh,
    required this.lastViewedPokemon,
  });

  final List<PokemonModel> pokemons;
  final HomeStatus status;
  final bool isRefresh;
  final String lastViewedPokemon;

  @override
  List<Object?> get props => [pokemons, status, isRefresh, lastViewedPokemon];
}