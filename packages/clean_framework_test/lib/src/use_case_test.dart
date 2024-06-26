// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_test/src/diff.dart';
import 'package:flutter_test/flutter_test.dart' as ft;
import 'package:meta/meta.dart';

@isTest
ProviderContainer
    useCaseTest<U extends UseCase<E>, E extends Entity, M extends DomainModel>(
  String description, {
  required UseCaseProviderBase provider,
  required FutureOr<void> Function(U) execute,
  dynamic Function()? expect,
  FutureOr<void> Function(U)? verify,
  E Function(E)? seed,
  ProviderContainer? container,
}) {
  final providerContainer = container ?? ProviderContainer();

  ft.test(
    description,
    () async {
      final useCase = provider.read(providerContainer) as U;

      if (seed != null) {
        useCase.entity = seed(useCase.entity);
      }

      final domainModels = <M>[];

      final completer = Completer<void>();
      final subscription = useCase.stream
          .map((e) => useCase.transformToDomainModel<M>(e))
          .distinct()
          .listen(domainModels.add, onDone: completer.complete);

      await execute(useCase);
      await Future<void>.delayed(Duration.zero);
      if (useCase.mounted) useCase.dispose();
      await completer.future;

      if (expect != null) {
        final dynamic expected = expect();
        final shallowEquality = '$domainModels' == '$expected';

        try {
          ft.expect(domainModels, ft.wrapMatcher(expected));
        } on ft.TestFailure catch (e) {
          if (shallowEquality || expected is! List<M>) rethrow;
          final difference = diff(expected: expected, actual: domainModels);
          throw ft.TestFailure('${e.message}\n$difference');
        }
      }

      await subscription.cancel();
      await verify?.call(useCase);
    },
  );

  return providerContainer;
}

@isTest
ProviderContainer useCaseBridgeTest<TU extends UseCase<E>, E extends Entity,
    M extends DomainModel, FU extends UseCase>(
  String description, {
  required UseCaseProviderBase from,
  required UseCaseProviderBase to,
  required FutureOr<void> Function(FU) execute,
  Iterable<dynamic> Function()? expect,
  FutureOr<void> Function(TU)? verify,
  E Function(E)? seed,
  ProviderContainer? container,
}) {
  final providerContainer = container ?? ProviderContainer();

  ft.test(
    description,
    () async {
      final fromUseCase = from.read(providerContainer) as FU;
      final toUseCase = to.read(providerContainer) as TU;

      if (seed != null) {
        toUseCase.entity = seed(toUseCase.entity);
      }

      final domainModels = <M>[];

      final completer = Completer<void>();
      final subscription = toUseCase.stream
          .map((e) => toUseCase.transformToDomainModel<M>(e))
          .distinct()
          .listen(domainModels.add, onDone: completer.complete);

      await execute(fromUseCase);
      await Future<void>.delayed(Duration.zero);
      if (toUseCase.mounted) toUseCase.dispose();
      await completer.future;

      if (expect != null) {
        final dynamic expected = expect();
        final shallowEquality = '$domainModels' == '$expected';

        try {
          ft.expect(domainModels, ft.wrapMatcher(expected));
        } on ft.TestFailure catch (e) {
          if (shallowEquality || expected is! List<M>) rethrow;
          final difference = diff(expected: expected, actual: domainModels);
          throw ft.TestFailure('${e.message}\n$difference');
        }
      }

      await subscription.cancel();
      await verify?.call(toUseCase);
    },
  );

  return providerContainer;
}
