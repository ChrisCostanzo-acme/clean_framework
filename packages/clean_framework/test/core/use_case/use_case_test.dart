import 'dart:async';

import 'package:clean_framework/clean_framework.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TestUseCase useCase;

  group('UseCase tests |', () {
    setUp(() {
      useCase = TestUseCase();
    });

    tearDown(() {
      useCase.dispose();
    });

    test('entity updates with setter', () {
      expect(useCase.debugEntity, const TestEntity());

      useCase.set(foo: 'bar');
      expect(useCase.debugEntity, const TestEntity(foo: 'bar'));
    });

    test('entity updates with setInput', () {
      expect(useCase.debugEntity, const TestEntity());

      useCase.setInput(const TestInput(foo: 'input'));
      expect(useCase.debugEntity, const TestEntity(foo: 'input'));
    });

    test(
      'entity update fails w/ setInput if no appropriate transformer is found',
      () {
        expect(useCase.debugEntity, const TestEntity());
        expect(
          () => useCase.setInput(const NoTransformerTestInput(foo: 'input')),
          throwsStateError,
        );
      },
    );

    test(
      'getOutput() success',
      () {
        expect(useCase.debugEntity, const TestEntity());

        useCase.setInput(const TestInput(foo: 'input'));

        final output = useCase.getDomainModel<TestDomainModel>();
        expect(output, const TestDomainModel(foo: 'input'));
      },
    );

    test(
      'getOutput() fails when no appropriate transformer is found',
      () {
        expect(useCase.debugEntity, const TestEntity());

        useCase.setInput(const TestInput(foo: 'input'));

        expect(
          useCase.getDomainModel<NoTransformerTestDomainModel>,
          throwsStateError,
        );
      },
    );

    test(
      'successful request',
      () async {
        expect(useCase.debugEntity, const TestEntity());

        useCase.subscribe<TestDomainToGatewayModel, TestSuccessInput>(
          (output) async {
            return Either.right(
              TestSuccessInput(message: 'Hello ${output.name}!'),
            );
          },
        );

        await useCase.request<TestSuccessInput>(
          const TestDomainToGatewayModel(name: 'World'),
          onSuccess: (success) => TestEntity(foo: success.message),
          onFailure: (failure) => const TestEntity(foo: 'failure'),
        );

        expect(
          useCase.debugEntity,
          const TestEntity(foo: 'Hello World!'),
        );
      },
    );

    test(
      'successful request with getInput',
      () async {
        expect(useCase.debugEntity, const TestEntity());

        useCase.subscribe<TestDomainToGatewayModel, TestSuccessInput>(
          (output) async {
            return Either.right(
              TestSuccessInput(message: 'Hello ${output.name}!'),
            );
          },
        );

        final input = await useCase.getInput(
          const TestDomainToGatewayModel(name: 'World'),
        );

        useCase.debugEntityUpdate(
          (entity) {
            return switch (input) {
              SuccessUseCaseInput(:final TestSuccessInput input) => TestEntity(
                  foo: input.message,
                ),
              _ => const TestEntity(foo: 'failure'),
            };
          },
        );

        expect(
          useCase.debugEntity,
          const TestEntity(foo: 'Hello World!'),
        );
      },
    );

    test(
      'failure request with getInput',
      () async {
        expect(useCase.debugEntity, const TestEntity());

        useCase.subscribe<TestDomainToGatewayModel, TestSuccessInput>(
          (output) async {
            return Either.left(
              FailureDomainInput(message: 'Failed ${output.name}!'),
            );
          },
        );

        final input = await useCase.getInput(
          const TestDomainToGatewayModel(name: 'World'),
        );

        useCase.debugEntityUpdate(
          (entity) {
            return switch (input) {
              SuccessUseCaseInput(:final TestSuccessInput input) => TestEntity(
                  foo: input.message,
                ),
              FailureUseCaseInput(:final input) =>
                TestEntity(foo: input.message),
              _ => const TestEntity(foo: 'failure'),
            };
          },
        );

        expect(
          useCase.debugEntity,
          const TestEntity(foo: 'Failed World!'),
        );
      },
    );

    test(
      'throws if there is no appropriate subscription present',
      () async {
        expect(
          () => useCase.request<TestSuccessInput>(
            const TestDomainToGatewayModel(name: 'World'),
            onSuccess: (success) => const TestEntity(),
            onFailure: (failure) => const TestEntity(),
          ),
          throwsStateError,
        );
      },
    );

    group('debounce', () {
      test(
        'performs action immediately first '
        'and then only after the duration elapses',
        () async {
          useCase.set(foo: '@');

          String getChar() => useCase.debugEntity.foo;

          void increment() {
            useCase.debounce(
              action: () {
                useCase.set(
                  foo: String.fromCharCode(getChar().codeUnitAt(0) + 1),
                );
              },
              tag: 'increment',
              duration: const Duration(milliseconds: 100),
            );
          }

          increment();
          expect(getChar(), equals('A'));

          await Future<void>.delayed(const Duration(milliseconds: 110));
          increment();
          expect(getChar(), equals('B'));

          await Future<void>.delayed(const Duration(milliseconds: 90));
          increment();
          expect(getChar(), equals('B'));

          await Future<void>.delayed(const Duration(milliseconds: 75));
          increment();
          expect(getChar(), equals('B'));

          await Future<void>.delayed(const Duration(milliseconds: 50));
          increment();
          expect(getChar(), equals('B'));

          await Future<void>.delayed(const Duration(milliseconds: 60));
          increment();
          expect(getChar(), equals('B'));

          await Future<void>.delayed(const Duration(milliseconds: 105));
          increment();
          expect(getChar(), equals('C'));

          await Future<void>.delayed(const Duration(milliseconds: 95));
          increment();
          expect(getChar(), equals('C'));

          await Future<void>.delayed(const Duration(milliseconds: 105));
          increment();
          expect(getChar(), equals('D'));
        },
      );

      test(
        'performs action only after the duration elapses; '
        'when immediate is false',
        () async {
          useCase.set(foo: 'A');

          String getChar() => useCase.debugEntity.foo;

          void increment() {
            useCase.debounce(
              action: () {
                useCase.set(
                  foo: String.fromCharCode(getChar().codeUnitAt(0) + 1),
                );
              },
              tag: 'increment',
              duration: const Duration(milliseconds: 100),
              immediate: false,
            );
          }

          increment();
          expect(getChar(), equals('A'));

          await Future<void>.delayed(const Duration(milliseconds: 110));
          increment();
          expect(getChar(), equals('B'));

          await Future<void>.delayed(const Duration(milliseconds: 90));
          increment();
          expect(getChar(), equals('B'));

          await Future<void>.delayed(const Duration(milliseconds: 75));
          increment();
          expect(getChar(), equals('B'));

          await Future<void>.delayed(const Duration(milliseconds: 50));
          increment();
          expect(getChar(), equals('B'));

          await Future<void>.delayed(const Duration(milliseconds: 60));
          increment();
          expect(getChar(), equals('B'));

          await Future<void>.delayed(const Duration(milliseconds: 105));
          increment();
          expect(getChar(), equals('C'));

          await Future<void>.delayed(const Duration(milliseconds: 95));
          increment();
          expect(getChar(), equals('C'));

          await Future<void>.delayed(const Duration(milliseconds: 105));
          increment();
          expect(getChar(), equals('D'));
        },
      );
    });

    test(
      'throws unimplemented error when trying to access copyWith; '
      'if copyWith is not overridden',
      () async {
        const entity = NoCopyWithEntity(foo: 'bar');

        expect(() => entity.copyWith(), throwsUnimplementedError);
      },
    );

    test(
      'updates within "withSilencedUpdate" are not notified to listeners',
      () async {
        expect(useCase.debugEntity, const TestEntity());

        final expectation = expectLater(
          useCase.stream,
          emitsInOrder(
            const [
              TestEntity(foo: 'bar'),
              TestEntity(foo: 'baz'),
            ],
          ),
        );

        useCase.set(foo: 'bar');
        expect(useCase.debugEntity, const TestEntity(foo: 'bar'));

        await useCase.withSilencedUpdate(() {
          // This update in not emitted on the stream above.
          useCase.set(foo: 'bas');
        });
        expect(useCase.debugEntity, const TestEntity(foo: 'bas'));

        useCase.set(foo: 'baz');
        expect(useCase.debugEntity, const TestEntity(foo: 'baz'));

        await expectation;
      },
    );

    test(
      'running multiple "withSilencedUpdate" modifier throws assertion error',
      () async {
        expect(useCase.debugEntity, const TestEntity());

        useCase.set(foo: 'bar');
        expect(useCase.debugEntity, const TestEntity(foo: 'bar'));

        unawaited(
          useCase.withSilencedUpdate(() async {
            useCase.set(foo: 'bas');

            await Future<void>.delayed(const Duration(milliseconds: 10));
          }),
        );
        expect(useCase.debugEntity, const TestEntity(foo: 'bas'));

        expect(
          useCase.withSilencedUpdate(() async {
            useCase.set(foo: 'baz');
          }),
          throwsAssertionError,
        );
        expect(useCase.debugEntity, const TestEntity(foo: 'bas'));
      },
    );

    test(
      'debugEntityUpdate updates the entity',
      () async {
        expect(useCase.debugEntity, const TestEntity());

        useCase.debugEntityUpdate((entity) => entity.copyWith(foo: 'bar'));
        expect(useCase.debugEntity, const TestEntity(foo: 'bar'));
      },
    );
  });
}

class TestUseCase extends UseCase<TestEntity> {
  TestUseCase()
      : super(
          entity: const TestEntity(),
          transformers: [
            TestInputTransformer(),
            TestOutputTransformer(),
          ],
        );

  void set({required String foo}) {
    entity = entity.copyWith(foo: foo);
  }
}

class TestEntity extends Entity {
  const TestEntity({this.foo = ''});

  final String foo;

  @override
  List<Object?> get props => [foo];

  @override
  TestEntity copyWith({String? foo}) => TestEntity(foo: foo ?? this.foo);
}

class TestInput extends SuccessDomainInput {
  const TestInput({required this.foo});

  final String foo;
}

class NoTransformerTestInput extends SuccessDomainInput {
  const NoTransformerTestInput({required this.foo});

  final String foo;
}

class TestDomainModel extends DomainModel {
  const TestDomainModel({required this.foo});

  final String foo;

  @override
  List<Object?> get props => [foo];
}

class TestDomainToGatewayModel extends DomainModel {
  const TestDomainToGatewayModel({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

class TestSuccessInput extends SuccessDomainInput {
  const TestSuccessInput({required this.message});

  final String message;
}

class NoTransformerTestDomainModel extends DomainModel {
  const NoTransformerTestDomainModel({required this.foo});

  final String foo;

  @override
  List<Object?> get props => [foo];
}

class TestInputTransformer
    extends DomainInputTransformer<TestEntity, TestInput> {
  @override
  TestEntity transform(TestEntity entity, TestInput input) {
    return entity.copyWith(foo: input.foo);
  }
}

class TestOutputTransformer
    extends DomainModelTransformer<TestEntity, TestDomainModel> {
  @override
  TestDomainModel transform(TestEntity entity) {
    return TestDomainModel(foo: entity.foo);
  }
}

class NoCopyWithEntity extends Entity {
  const NoCopyWithEntity({this.foo = ''});

  final String foo;

  @override
  List<Object?> get props => [foo];
}
