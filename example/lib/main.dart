// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:example/my_app.dart';
import 'package:flutter/material.dart';
import 'package:surf_logger/surf_logger.dart';

/// Starting from version 2.0.0, the logger is no longer a singleton.
/// Therefore, it needs to be passed as a dependency or made global.
void main() {
  final logger = _setupLogger();

  runApp(MyApp(logger: logger));
}

LogWriter _setupLogger() {
  /// Simple log strategy for quick start with Surf Logger.
  return Logger.withStrategies({SimpleLogStrategy()});
}
