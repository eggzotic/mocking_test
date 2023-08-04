# mocking_test

Demo app of how to provide selective-mock data to widgets, in such a way as to avoid disturbing the production code. Mock data is brought in thru a config.json file (which must be defined as an asset in pubspec.yaml), from the `MockSomeSetup` class, so that the widgets are not modified at all. This allows UI code to cover all cases, via providing the various possible data. Requests to paths that do not have mock response/data defined will pass-thru to the real remote end-point - useful if only a few routes need mocking.

Note that the use-case for this is more for developing, rather than unit-testing. It helps exercise your widgets which require rarely-received data (e.g. errors or not-yet-built endpoints).

## Getting Started

Inspired by the `http_mock_adapter` package, and the suggestions/solutions discussed at https://github.com/lomsa-dev/http-mock-adapter/issues/136, which builds on the capabilities of Dio.

- ```dart run build_runner build --delete-conflicting-outputs```
- ```flutter run -d chrome```

Richard Shepherd
August 2023
