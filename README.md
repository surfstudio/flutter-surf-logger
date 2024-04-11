# Surf Logger

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/surfstudio/flutter-open-source/blob/887525c23f4d57a2d96fc2e6a31e15d1e29d1787/assets/logo_white.png">
  <img alt="Shows an illustrated sun in light color mode and a moon with stars in dark color mode." src="https://github.com/surfstudio/flutter-open-source/blob/887525c23f4d57a2d96fc2e6a31e15d1e29d1787/assets/logo_black.png" width ="200">
</picture>

Made by [Surf 🏄‍♂️🏄‍♂️🏄‍♂️](https://surf.dev)

[![Build Status](https://shields.io/github/actions/workflow/status/surfstudio/flutter-surf-logger/on_pull_request.yml?logo=github&logoColor=white)](https://github.com/surfstudio/flutter-surf-logger)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/flutter-surf-logger?logo=codecov&logoColor=white)](https://app.codecov.io/gh/surfstudio/flutter-surf-logger)
[![Pub Version](https://img.shields.io/pub/v/surf_logger?logo=dart&logoColor=white)](https://pub.dev/packages/surf_logger)
[![Pub Likes](https://badgen.net/pub/likes/surf_logger)](https://pub.dev/packages/surf_logger)
[![Pub popularity](https://badgen.net/pub/popularity/surf_logger)](https://pub.dev/packages/surf_logger/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/surf_logger)

## Overview

Surf Logger is a utility that allows for quick and easy configuration of logging for a production-level application.

This library does not limit your use of third-party loggers. Instead, it provides a tool for configuring logging within your application.

## Installation

Add `surf_logger` to your `pubspec.yaml` file:

```yaml
dependencies:
  surf_logger: $currentVersion$
```

<p>At this moment, the current version of <code>surf_logger</code> is <a href="https://pub.dev/packages/surf_logger"><img style="vertical-align:middle;" src="https://img.shields.io/pub/v/surf_logger.svg" alt="surf_logger version"></a>.</p>

## Example

### Creating your own strategy

You can create your own logging strategy for different needs: logging to your own server, through Firebase, through Sentry, etc.

```dart
class FirebaseLogStrategy implements LogStrategy {
  final FirebaseCrashlytics _crashlytics;

  CrashlyticsLogStrategy(this._crashlytics);

  @override
  void e(Exception exception, [StackTrace? stackTrace]) {
    _crashlytics.recordError(exception, stackTrace);
  }

  @override
  void log(Object message) {
    _crashlytics.log('$message');
    print('Message: $message');
  }

  @override
  void w(String message, [Exception? exception]) {
    _crashlytics.log('Warning: $message \n Exception: $exception');
  }
}
```

### Choosing a strategy for the circumstances

You can configure the logger for the circumstances. For example, for the application flavor:

```dart
LogWriter setupLogger(Env env) {
  return Logger.withStrategies({
    if (env == Env.dev || env == Env.qa) ConsoleLogStrategy(),
    if (env == Env.client || env == Env.qa) FileLogStrategy(),
    if (env == Env.prod) ...[
      FirebaseLogStrategy(),
      SentryLogStrategy(),
    ],
  });
}
```

Please note that `Logger` is a class for configuration, while `LogWriter` is for usage. This way, we provide access only to the necessary methods for logging, namely `log`, `e`, and `w`.

For instance, the following methods will be available to an instance of `LogWriter`:

```dart
void main() {
  final LogWriter logger = _setupLogger();
  runApp(MyApp(logger: logger));
  logger.log('message');
  logger.e(Exception('exception'));
  logger.w('message');
}
```

And an instance of `Logger` will have configuration management methods available. It's important to avoid using this class for other purposes, as it could potentially disrupt the configuration.

```dart
void main() {
  final Logger logger = _setupLogger();
  runApp(MyApp(logger: logger));
  logger.log('message');
  logger.contains(SomeLogStrategy());
  logger.addStrategy(SomeLogStrategy());
  logger.clearStrategies();
  logger.e(Exception('exception'));
  logger.w('message');
}
```

## Migrating from 1.x.x to 2.x.x

1.x.x

```dart
void setupLogger() {
  RemoteLogger.addStrategy(CrashlyticsRemoteLogStrategy());
  Logger.addStrategy(DebugLogStrategy());
  Logger.addStrategy(RemoteLogStrategy());
}
```

Starting from version 2.0.0, the logger is no longer a singleton. Now, you need to create an instance of the logger.
`RemoteLogger` has been removed. Use `LogStrategy` to create any required strategy.

```dart
LogWriter setupLogger() {
  return Logger.withStrategies({
    CrashlyticsRemoteLogStrategy,
    DebugLogStrategy,
    RemoteLogStrategy(),
  });
}
```

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues

To report your issues, file directly in the [Issues](https://github.com/surfstudio/flutter-surf-logger/issues) section.

## Contribute

If you would like to contribute to the package (e.g. by improving the documentation, fixing a bug or adding a cool new feature), please read our [contribution guide](./CONTRIBUTING.md) first and send us your pull request.

Your PRs are always welcome.

## How to reach us

Please feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
