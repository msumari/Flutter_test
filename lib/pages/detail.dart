import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {




OverlayEntry? entry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            showOverlay();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFFd66394),
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
            Color(0xFFd66394),
            Color(0xFFca6da1),
            Color(0xFFc273a9),
            Color(0xFFba7ab2),
            Color(0xFFb181bb),
            Color(0xFFad85c1),
            Color(0xFFa18fce),
            Color(0xFFa38fcd),
            Color(0xFF9b94d4),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: const Center(
            child: Text('POP me'),
          )),
    );


  }
  void showOverlay() {
    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: 85,
        bottom: 150,
        child: OutlinedButton(
          child: const Text(
            'Details',
            style: TextStyle(color: Colors.white),
          ),
          style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF5e53c1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              shadowColor: const Color(0xFF9b94d4),
              elevation: 5,
              fixedSize: const Size(150, 45)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Details()));
                hideoverlay();
          },
        ),
      ),
    );

    final overlay = Overlay.of(context);
    overlay!.insert(entry!);
  }
void hideoverlay() {
    entry?.remove();
    entry = null;
  }
}
