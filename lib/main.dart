import 'package:flutter/material.dart';

void main() {
  runApp(const Show());
}

String msg = 'checked';

class CButton extends StatelessWidget {
  const CButton(
      {required this.icons,
      required this.isClicked,
      required this.onTap,
      super.key});

  final List<Icon> icons;
  final bool isClicked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.blue),
        child: !isClicked ? icons[0] : icons[1],
      ),
    );
  }
}

class ReactOnClick extends StatefulWidget {
  const ReactOnClick({super.key});

  @override
  State<ReactOnClick> createState() => _ReactOnClickState();
}

class _ReactOnClickState extends State<ReactOnClick> {
  bool _isClicked = false;
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  void _click() {
    setState(() {
      msg = _isClicked ? 'checked' : 'unchecked';
      _isClicked = !_isClicked;
    });
    tooltipkey.currentState?.ensureTooltipVisible();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Center(
            child: CButton(icons: const [
          Icon(
            Icons.circle_outlined,
            color: Colors.white,
            size: 25,
          ),
          Icon(
            Icons.clear_sharp,
            color: Colors.white,
            size: 25,
          )
        ], isClicked: _isClicked, onTap: _click)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Tooltip(
            key: tooltipkey,
            triggerMode: TooltipTriggerMode.manual,
            showDuration: const Duration(seconds: 1),
            padding: const EdgeInsets.all(20.0),
            textStyle: const TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
            decoration:
                BoxDecoration(color: const Color.fromRGBO(0, 0, 0, 0.76),
                  borderRadius: BorderRadius.circular(45.0)),
            message: msg,
            child: const Text(''),
          ),
        ),
      ],
    );
  }
}

class Show extends StatelessWidget {
  const Show({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test04',
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: const Text('test04')),
        body: const ReactOnClick(),
      ),
    );
  }
}
