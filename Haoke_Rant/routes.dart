import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/pages/home/home.dart';
import 'package:hello_world/pages/login.dart';
import 'package:hello_world/pages/not_found.dart';
import 'package:hello_world/pages/room/room.dart';
import 'package:hello_world/pages/register.dart';

class Routes {
//   1. 定义路由名称
  static String home = '/';
  static String login = '/login';
  static String register = '/register';
  static String roomDetail = '/room/:roomId';

// 2. 定义路由处理函数
  static Handler homeHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return HomePage();
  });
  static Handler loginHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return LoginPage();
  });

  static Handler notFound404Handler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return NotFoundPage();
  });

  static Handler roomDetailHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return RoomDetailPage(roomId: params['roomId'][0],);
    
  });

  static Handler _registerHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return RegisterPage();
  });

// 3. 编写函数 configureRoutes 关联路由名称和处理函数
  static void configureRoutes(Router router) {
    router.define(home, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.define(register, handler: _registerHandler);
    router.define(roomDetail, handler: roomDetailHandler);
    router.notFoundHandler = notFound404Handler;
  }
}