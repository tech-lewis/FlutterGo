//library hello_world;
import 'package:sky/widgets/basic.dart';

class HelloWorldApp extends App {
  Widget build() {
    return new Text('Hello, world!');
    //Center(child: new Text('Hello, world!'))
    // DSL布局方式的改变
  }
}

void main() {
  runApp(new HelloWorldApp());
}