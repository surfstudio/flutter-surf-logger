# Changelog

## 2.0.0

* **BREAKING:** You'll need to migrate your code.
* Logger is no longer a singleton. When using the package, issues were observed with mocking data for testing. There was also an issue with configuring the logger for different scopes (inability to create two different instances).
* Since Logger is no longer a singleton, it can now be inherited from.
* With the inheritance issue resolved, RemoteLogger has been removed.
* Dependency on the external logger has been removed. To use a specific logger, a strategy needs to be defined. Configured loggers will be added as separate packages.
* Logger with modification/configuration methods is now separated from LogWriter. This ensures that one does not have to worry about someone accidentally altering its configuration when injecting the logger.

## 1.1.0

### Added
* LogStrategy to public API

## 1.0.2

* Internal improvements.

## 1.0.1

* Stable release

## 1.0.0-dev.1

* Apply new lint rules.

## 1.0.0

* Migrated to null safety, min SDK is `2.12.0`.

## 0.0.1-dev.8

* Hide stacktrace in DebugLogStrategy output

## 0.0.1-dev.6

* Replace print in DebugLogStrategy to third library Logger

## 0.0.1-dev.5

* Fix lint hints

## 0.0.1-dev.1

* fix errors

## 0.0.1-dev.0

* initial release
