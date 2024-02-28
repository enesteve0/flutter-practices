import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('images/enes.JPG'),
            ),
            const Text(
              'Enes Özkan',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'FLUTTER DEVELOPER',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                color: Colors.blue[100],
                fontSize: 20.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.blue[100],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: const Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
                title: Text(
                  '+90 539 363 96 15',
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontFamily: 'Source Sans Pro',
                    fontSize: 20.0,
                  ),
                ),
                onTap: () => launch('tel:+905393639615'),
              )
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: const Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                title: Text(
                  'enesteve@enesteve.com',
                  style: TextStyle(fontSize: 20.0, color: Colors.blue[900]!, fontFamily: 'Source Sans Pro'),
                ),
                onTap: () => launch('mailto:enesteve@enesteve.com'),
              )
            )
          ],
        )),
      ),
    );
  }
}