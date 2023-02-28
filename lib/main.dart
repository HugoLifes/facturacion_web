import 'package:facturacion_web/src/main_screen/search_id.dart';
import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';

void main() async {
  Odoo odoo =
      Odoo(Connection(url: Url(Protocol.http, "localhost", 8069), db: 'odoo'));

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
          primaryColor: primaryColor,
          canvasColor: canvasColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          textTheme: GoogleFonts.montserratTextTheme()),
      home: MyHomePage(
        title: 'Bienvenido',
        odoo: odoo,
      ),
    );
  }
}

const primaryColor = Color(0xFF0061a4);
const canvasColor = Color(0xFFffffff);
const scaffoldBackgroundColor = Color(0xFFffffff);
const accentCanvasColor = Color(0xFFd7e3f8);
const white = Colors.white;
final actionColor = Color(0xFFd1e4ff);
final divider = Divider(color: accentCanvasColor, height: 1);
const colorIcon = Color(0xFF1a1c1e);
const unselectColor = Color(0xFF535f70);
const selectColor = Color(0xFFdde4ff);

TextStyle largeText =
    GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.bold);

TextStyle normalText = GoogleFonts.montserrat(fontSize: 15);

TextStyle rowText =
    GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w400);
