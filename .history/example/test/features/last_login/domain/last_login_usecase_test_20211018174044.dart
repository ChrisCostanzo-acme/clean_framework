import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_providers.dart';
import 'package:clean_framework_example/features/last_login/domain/last_login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('UseCase initial UI output and fetchDate', () async {
    final useCase = LastLoginUseCase();

    // Subscription shortcut to mock the response from a Gateway
    final currentDate = DateTime.parse('2021-12-31');
    useCase.subscribe(
        LastLoginDateOutput,
        (_) => Right<FailureInput, LastLoginDateInput>(
            LastLoginDateInput(currentDate)));

    var output = useCase.getOutput<LastLoginUIOutput>();
    expect(output, LastLoginUIOutput(lastLogin: DateTime.parse('1900-01-01')));

    var ctaOutput = useCase.getOutput<LastLoginCTAUIOutput>();
    expect(ctaOutput, LastLoginCTAUIOutput(isLoading: false));

    await useCase.fetchCurrentDate();

    output = useCase.getOutput<LastLoginUIOutput>();
    expect(output, LastLoginUIOutput(lastLogin: currentDate));

    ctaOutput = useCase.getOutput<LastLoginCTAUIOutput>();
    expect(ctaOutput, LastLoginCTAUIOutput(isLoading: false));

    // For coverage purposes
    expect(LastLoginDateOutput(), LastLoginDateOutput());
  });

  test('UseCase initial UI output and fetchDate', () async {
    final useCase = LastLoginUseCase();

    // Subscription shortcut to mock the response from a Gateway
    final currentDate = DateTime.parse('2021-12-31');
    useCase.subscribe(LastLoginDateOutput,
        (_) => Left<FailureInput, LastLoginDateInput>(FailureInput()));

    await useCase.fetchCurrentDate();

    var output = useCase.getOutput<LastLoginUIOutput>();

    // on a failure, the usecase keeps the old data
    expect(output, LastLoginUIOutput(lastLogin: DateTime.parse('1900-01-01')));
  });
}