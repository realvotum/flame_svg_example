import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_svg/svg.dart' as flame_svg;
import 'package:flame_svg/svg_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Game game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: SvgPicture.asset(
              'assets/tap.svg',
              width: 300,
              height: 300,
            ),
          )),
          Expanded(
            child: GameWidget(game: game),
          )
        ],
      ),
    );
  }
}

class SvgTapComponent extends PositionComponent {
  SvgTapComponent(Vector2 position) : super(position: position);

  @override
  Future<void> onLoad() async {
    final svgInstance = await flame_svg.Svg.load('tap.svg');
    final size = Vector2.all(300);
    final svgComponent =
        SvgComponent(svg: svgInstance, size: size, anchor: Anchor.center);
    add(svgComponent);
  }
}

class Game extends FlameGame {
  @override
  Color backgroundColor() => const Color(0x00000000);

  @override
  Future<void> onLoad() async {
    add(SvgTapComponent(camera.gameSize / 2));
  }
}
