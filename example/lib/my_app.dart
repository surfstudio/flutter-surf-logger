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

import 'package:example/pages/counter_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_logger/surf_logger.dart';

///
class MyApp extends StatelessWidget {
  final LogWriter logger;

  MyApp({required this.logger, super.key}) {
    logger.log('MyApp constructor');
  }

  @override
  Widget build(BuildContext context) {
    logger.log('MyApp build');

    return Provider.value(
      value: logger,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CounterPage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
