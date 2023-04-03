import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_rest/clean_framework_rest.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RestGateway success response', () async {
    final gateway = TestGateway()
      ..feedResponse(
        (request) => const Either.right(
          RestSuccessResponse(data: {'foo': 'bar'}),
        ),
      );

    final input = await gateway.buildInput(TestOutput());
    expect(input.isRight, isTrue);
    expect(input.right.data, {'foo': 'bar'});
  });

  test('RestGateway failure response', () async {
    final gateway = TestGateway()
      ..feedResponse(
        (request) => Either.left(UnknownFailureResponse('failure')),
      );

    final input = await gateway.buildInput(TestOutput());
    expect(input.isLeft, isTrue);
    expect(input.left, isA<FailureInput>());
  });

  test('other requests', () {
    final request = TestPostRequest();
    expect(request, isNotNull);
    expect(request.data, isEmpty);
    expect(TestPutRequest(), isNotNull);
    expect(TestPatchRequest(), isNotNull);
    expect(TestDeleteRequest(), isNotNull);
  });
}

class TestGateway
    extends RestGateway<TestOutput, TestRequest, TestSuccessInput> {
  @override
  TestRequest buildRequest(TestOutput output) {
    return TestRequest();
  }

  @override
  TestSuccessInput onSuccess(RestSuccessResponse response) {
    return TestSuccessInput(data: response.data);
  }
}

class TestOutput extends Output {
  @override
  List<Object?> get props => [];
}

class TestRequest extends GetRestRequest {
  @override
  String get path => 'http://fake.com';
}

class TestPostRequest extends PostRestRequest {
  @override
  String get path => 'http://fake.com';
}

class TestPutRequest extends PutRestRequest {
  @override
  String get path => 'http://fake.com';
}

class TestPatchRequest extends PatchRestRequest {
  @override
  String get path => 'http://fake.com';
}

class TestDeleteRequest extends DeleteRestRequest {
  @override
  String get path => 'http://fake.com';
}

class TestSuccessInput extends SuccessInput {
  const TestSuccessInput({required this.data});

  final Object data;
}