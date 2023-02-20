import 'package:facturacion_web/src/main_screen/search_id.dart';
import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';

void main() async {
  Odoo odoo = Odoo(
      Connection(url: Url(Protocol.http, "localhost", 8069), db: 'hugodb'));

  odoo.session.stream.listen((event) {
    print('session changed ${event?.toJson()}');
  });
  await connect(odoo);

  runApp(MyApp(
    odoo: odoo,
  ));
}

class MyApp extends StatelessWidget {
  Odoo? odoo;
  UserLoggedIn? user;
  MyApp({
    super.key,
    this.odoo,
    this.user,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Bienvenido',
        odoo: odoo,
      ),
    );
  }
}
