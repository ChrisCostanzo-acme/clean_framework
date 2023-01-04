import 'package:clean_framework/clean_framework_core.dart';
import 'package:clean_framework_example/features/home/domain/home_entity.dart';

class HomeUIOutput extends Output {
  HomeUIOutput({
    required this.pokemons,
    required this.status,
    required this.isRefresh,
  });

  final List<PokemonModel> pokemons;
  final HomeStatus status;
  final bool isRefresh;

  @override
  List<Object?> get props => [pokemons, status, isRefresh];
}
