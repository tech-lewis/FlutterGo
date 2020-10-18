// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_world/routes.dart';
// 编辑器主动地导入
import 'package:hello_world/pages/home/home.dart';
import 'package:hello_world/pages/login.dart';

void main(){
  runApp(App());
}


//https://material.io/ 官网
class App extends StatelessWidget {
  const App({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final Router router = Router();
    
    Routes.configureRoutes(router);
    return MaterialApp(
      //home: LoginPage(),
      theme: ThemeData(primaryColor: Colors.lightBlue),
      onGenerateRoute: router.generator,
    );
  }
}