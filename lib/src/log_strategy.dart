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

import 'package:surf_logger/src/log_writer.dart';

/// Base class for log strategies.
///
/// This class is an abstract base class for log strategies. A log strategy is a class
/// that provides a specific way of logging messages, exceptions, and warnings. To create
/// a custom log strategy, you should extend this class and implement the `log`, `e`, and `w`
/// methods.
abstract class LogStrategy extends LogWriter {}
