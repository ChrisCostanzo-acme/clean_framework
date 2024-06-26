import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:clean_framework_test/clean_framework_test_legacy.dart';
import 'package:flutter_test/flutter_test.dart';

final context = ProvidersContext();

void main() {
  test('Gateway unit test for success on direct output', () async {
    final useCase = UseCaseFake();
    final provider = UseCaseProvider((_) => useCase);
    TestDirectGateway(provider).transport = (request) async {
      return const Either.right(TestResponse('success'));
    };

    await useCase.doFakeRequest(const TestDirectDomainModel('123'));

    expect(useCase.entity, const EntityFake(value: 'success'));
  });

  test('Gateway unit test for failure on direct output', () async {
    final useCase = UseCaseFake();
    final provider = UseCaseProvider((_) => useCase);
    TestDirectGateway(provider).transport = (request) async {
      return Either.left(UnknownFailureResponse());
    };

    await useCase.doFakeRequest(const TestDirectDomainModel('123'));

    expect(useCase.entity, const EntityFake(value: 'failure'));
  });

  test('Gateway unit test for success on yield output', () async {
    final useCase = UseCaseFake();
    final provider = UseCaseProvider((_) => useCase);
    final gateway = TestYieldGateway(provider)
      ..transport = (request) async {
        return const Either.right(TestResponse('success'));
      };

    await useCase.doFakeRequest(const TestSubscriptionDomainModel('123'));

    expect(useCase.entity, const EntityFake(value: 'success'));

    gateway.yieldResponse(const TestResponse('with yield'));

    expect(useCase.entity, const EntityFake(value: 'success with input'));
  });

  test('Gateway unit test for failure on yield output', () async {
    final useCase = UseCaseFake();
    final provider = UseCaseProvider((_) => useCase);
    TestYieldGateway(provider).transport = (request) async {
      return Either.left(UnknownFailureResponse());
    };

    await useCase.doFakeRequest(const TestSubscriptionDomainModel('123'));

    expect(useCase.entity, const EntityFake(value: 'failure'));
  });

  test('props', () {
    // ignore: prefer_const_constructors
    final response = SuccessResponse();
    expect(response, const SuccessResponse());
    // If we log the responses and compare the output, that could replace this
    expect(response.stringify, isTrue);
  });
}

class TestDirectGateway extends Gateway<TestDirectDomainModel, TestRequest,
    TestResponse, TestSuccessInput> {
  TestDirectGateway(UseCaseProvider provider)
      : super(provider: provider, context: context);

  @override
  TestRequest buildRequest(TestDirectDomainModel output) =>
      TestRequest(output.id);

  @override
  FailureDomainInput onFailure(FailureResponse failureResponse) {
    return const FailureDomainInput(message: 'backend error');
  }

  @override
  TestSuccessInput onSuccess(TestResponse response) {
    return TestSuccessInput(response.foo);
  }
}

class TestYieldGateway extends WatcherGateway<TestSubscriptionDomainModel,
    TestRequest, TestResponse, TestSuccessInput> {
  TestYieldGateway(UseCaseProvider provider)
      : super(provider: provider, context: context);

  @override
  TestRequest buildRequest(TestSubscriptionDomainModel output) =>
      TestRequest(output.id);

  @override
  FailureDomainInput onFailure(FailureResponse failureResponse) {
    return const FailureDomainInput(message: 'backend error');
  }

  @override
  TestSuccessInput onSuccess(TestResponse response) {
    return TestSuccessInput(response.foo);
  }
}

class TestRequest extends Request {
  const TestRequest(this.id);
  final String id;
}

class TestResponse extends SuccessResponse {
  const TestResponse(this.foo);
  final String foo;

  @override
  List<Object?> get props => [foo];
}

class TestSuccessInput extends SuccessDomainInput {
  const TestSuccessInput(this.foo);
  final String foo;
}

class TestDirectDomainModel extends DomainModel {
  const TestDirectDomainModel(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}

class TestSubscriptionDomainModel extends DomainModel {
  const TestSubscriptionDomainModel(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}
