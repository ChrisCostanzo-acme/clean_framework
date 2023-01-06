import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:clean_framework_firestore/clean_framework_firestore.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FirebaseClientFake firebaseClient;
  final testContent = {'foo': 'bar'};

  firebaseClient = FirebaseClientFake(testContent);

  tearDownAll(() {
    firebaseClient.dispose();
  });

  test('FirebaseExternalInterface watch id request', () async {
    // to cover the internal initialize of FirebaseClient
    expect(
      () => FirebaseExternalInterface(gatewayConnections: []),
      throwsException,
    );

    final gateWay =
        WatcherGatewayFake<FirebaseWatchIdRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: firebaseClient,
      gatewayConnections: [() => gateWay],
    );

    final result = await gateWay
        .transport(const FirebaseWatchIdRequest(path: 'fake path', id: 'foo'));
    expect(result.isRight, isTrue);
    expect(result.right, FirebaseSuccessResponse(testContent));

    if (gateWay.hasYielded.isCompleted) {
      expect(gateWay.successResponse, FirebaseSuccessResponse(testContent));
    } else {
      await expectLater(
        gateWay.hasYielded.future,
        completion(FirebaseSuccessResponse(testContent)),
      );
    }
  });

  test('FirebaseExternalInterface watch all request', () async {
    final gateWay =
        WatcherGatewayFake<FirebaseWatchAllRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: firebaseClient,
      gatewayConnections: [() => gateWay],
    );

    final result = await gateWay.transport(
      const FirebaseWatchAllRequest(path: 'fake path'),
    );
    expect(result.isRight, isTrue);
    expect(result.right, FirebaseSuccessResponse(testContent));

    if (gateWay.hasYielded.isCompleted) {
      expect(gateWay.successResponse, FirebaseSuccessResponse(testContent));
    } else {
      await expectLater(
        gateWay.hasYielded.future,
        completion(FirebaseSuccessResponse(testContent)),
      );
    }

    firebaseClient.dispose();
  });

  test('FirebaseExternalInterface read id request', () async {
    final gateWay =
        GatewayFake<FirebaseReadIdRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: firebaseClient,
      gatewayConnections: [() => gateWay],
    );

    final result = await gateWay
        .transport(const FirebaseReadIdRequest(path: 'fake path', id: 'foo'));
    expect(result.isRight, isTrue);
    expect(result.right, FirebaseSuccessResponse(testContent));
  });

  test('FirebaseExternalInterface read all request', () async {
    final gateWay =
        GatewayFake<FirebaseReadAllRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: firebaseClient,
      gatewayConnections: [() => gateWay],
    );

    final result = await gateWay
        .transport(const FirebaseReadAllRequest(path: 'fake path'));
    expect(result.isRight, isTrue);
    expect(result.right, FirebaseSuccessResponse(testContent));
  });

  test('FirebaseExternalInterface write request', () async {
    final firebaseClient = FirebaseClientFake(testContent);
    final gateWay =
        GatewayFake<FirebaseWriteRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: firebaseClient,
      gatewayConnections: [() => gateWay],
    );

    final result = await gateWay
        .transport(const FirebaseWriteRequest(path: 'fake path', id: 'foo'));
    expect(result.isRight, isTrue);
    expect(result.right, const FirebaseSuccessResponse({'id': 'id'}));

    firebaseClient.dispose();
  });

  test('FirebaseExternalInterface write request without id', () async {
    final firebaseClient = FirebaseClientFake(testContent);
    final gateWay =
        GatewayFake<FirebaseWriteRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: firebaseClient,
      gatewayConnections: [() => gateWay],
    );

    final result =
        await gateWay.transport(const FirebaseWriteRequest(path: 'fake path'));
    expect(result.isRight, isTrue);
    expect(result.right, const FirebaseSuccessResponse({'id': 'id'}));

    firebaseClient.dispose();
  });

  test('FirebaseExternalInterface update request', () async {
    final gateWay =
        GatewayFake<FirebaseUpdateRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: firebaseClient,
      gatewayConnections: [() => gateWay],
    );

    final result = await gateWay
        .transport(const FirebaseUpdateRequest(path: 'fake path', id: 'foo'));
    expect(result.isRight, isTrue);
    expect(result.right, const FirebaseSuccessResponse({}));
  });

  test('FirebaseExternalInterface delete request', () async {
    final gateWay =
        GatewayFake<FirebaseDeleteRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: firebaseClient,
      gatewayConnections: [() => gateWay],
    );

    final result = await gateWay
        .transport(const FirebaseDeleteRequest(path: 'fake path', id: 'foo'));
    expect(result.isRight, isTrue);
    expect(result.right, const FirebaseSuccessResponse({}));
  });

  test('FirebaseExternalInterface read id no content', () async {
    firebaseClient = FirebaseClientFake({});

    final gateWay =
        GatewayFake<FirebaseReadIdRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: firebaseClient,
      gatewayConnections: [() => gateWay],
    );

    final result = await gateWay
        .transport(const FirebaseReadIdRequest(path: 'fake path', id: 'foo'));
    expect(result.isLeft, isTrue);
    expect(
      result.left,
      const FirebaseFailureResponse(type: FirebaseFailureType.noContent),
    );

    firebaseClient.dispose();
  });

  test('FirebaseExternalInterface read all no content', () async {
    firebaseClient = FirebaseClientFake({});

    final gateWay =
        GatewayFake<FirebaseReadAllRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: firebaseClient,
      gatewayConnections: [() => gateWay],
    );

    final result = await gateWay
        .transport(const FirebaseReadAllRequest(path: 'fake path'));
    expect(result.isLeft, isTrue);
    expect(
      result.left,
      const FirebaseFailureResponse(type: FirebaseFailureType.noContent),
    );

    firebaseClient.dispose();
  });

  test('FirebaseExternalInterface write no content', () async {
    final firebaseClient = FirebaseClientFake({});
    final gateWay =
        GatewayFake<FirebaseWriteRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: firebaseClient,
      gatewayConnections: [() => gateWay],
    );

    final result = await gateWay
        .transport(const FirebaseWriteRequest(path: 'fake path', id: 'foo'));
    expect(result.isLeft, isTrue);
    expect(
      result.left,
      const FirebaseFailureResponse(type: FirebaseFailureType.noContent),
    );

    firebaseClient.dispose();
  });

  test('FirebaseExternalInterface query', () async {
    FirebaseClientFake({})
      ..createQuery('fake', (_) => _)
      ..clearQuery()
      ..dispose();
  });

  test('FirebaseExternalInterface read with unknown exception', () async {
    firebaseClient = FirebaseClientFake({});

    final gateWay =
        GatewayFake<FirebaseReadIdRequest, FirebaseSuccessResponse>();
    FirebaseExternalInterface(
      firebaseClient: FirebaseClientFake({}, 'exception message'),
      gatewayConnections: [() => gateWay],
    );

    final result = await gateWay.transport(
      const FirebaseReadIdRequest(path: 'fake path', id: 'foo'),
    );
    expect(result.isLeft, isTrue);
    expect(
      result.left,
      isA<UnknownFailureResponse>().having(
        (r) => r.message,
        'message',
        'exception message',
      ),
    );

    firebaseClient.dispose();
  });
}
