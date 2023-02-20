import 'dart:convert';

import 'package:facturacion_web/src/main_screen/model/form_model.dart';
import 'package:facturacion_web/src/main_screen/model/query_model.dart';
import 'package:facturacion_web/src/view/order_view_list.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:odoo/odoo.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

Future<UserLoggedIn> connect(Odoo odoo) async {
  return await odoo.connect(Credential('admin', 'admin'));
}

final dio = Dio();

class MyHomePage extends StatefulWidget {
  String? title;
  Odoo? odoo;

  MyHomePage({super.key, this.title, this.odoo});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState>? _OrdenIdformKey = GlobalKey<FormState>();
  final GlobalKey<FormState>? _RFCformKey = GlobalKey<FormState>();
  final GlobalKey<FormState>? _SocioIDformKey = GlobalKey<FormState>();
  TextEditingController tk = TextEditingController();
  TextEditingController tk2 = TextEditingController();
  TextEditingController tk3 = TextEditingController();
  List<OrderM>? orders = [];
  IdModel? ids;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: LoaderOverlay(
        child: ListView(
          padding: EdgeInsets.only(
              right: size.width > 800
                  ? size.width > 900
                      ? size.width * 0.3
                      : size.width * 0.3
                  : size.width * 0.1,
              left: size.width > 800
                  ? size.width > 900
                      ? size.width * 0.3
                      : size.width * 0.3
                  : size.width * 0.1),
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('Aqui va una posible imagen'),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ]),
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: const Text(
                          'Bienvenido',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 22),
                        ),
                      ),
                      Text(
                        'Busca tus facturas',
                        style: TextStyle(
                            color: Colors.grey.withOpacity(1.0),
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          title: const Text(
                            'OrdenID',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text(
                              'Crea tu factura por ID orden de compra',
                              style: TextStyle(fontWeight: FontWeight.w400)),
                          children: <Widget>[
                            FormModel('OrdenID', _OrdenIdformKey!, tk).idForm()
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          title: const Text(
                            'RFC',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text('Crea tus facturas por RFC',
                              style: TextStyle(fontWeight: FontWeight.w400)),
                          children: <Widget>[
                            FormModel('RFC', _RFCformKey!, tk2).idForm()
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          title: const Text(
                            'ID Socio',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text('Facture con su id de socio',
                              style: TextStyle(fontWeight: FontWeight.w400)),
                          children: <Widget>[
                            FormModel('ID Socio', _SocioIDformKey!, tk3)
                                .idForm()
                          ],
                        ),
                      ),
                      okButton(context)
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell okButton(
    BuildContext context,
  ) {
    return InkWell(
      onTap: () async {
        final idInfo = tk.text;
        final idInfo2 = tk2.text;
        final idInfo3 = tk3.text;
        print('1:$idInfo');
        print('2:$idInfo2');
        print('3:$idInfo3');
        if (tk.text.isNotEmpty) {
          idConfirmation(context, 1);
        } else if (tk2.text.isNotEmpty) {
          idConfirmation(context, 2);
        } else if (tk3.text.isNotEmpty) {
          idConfirmation(context, 3);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Buscar',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }

  void idConfirmation(BuildContext context, int type) {
    switch (type) {
      case 1:
        print('Uno');
        if (_OrdenIdformKey!.currentState!.validate()) {
          context.loaderOverlay
              .show(widget: const Center(child: CircularProgressIndicator()));
          orderResponse(type, tk.text)
              .then((value) => {})
              .whenComplete(() => {context.loaderOverlay.hide()});
        } else {
          print('Algo salio mal');
        }

        break;
      case 2:
        print('Dos');
        if (_RFCformKey!.currentState!.validate()) {
          context.loaderOverlay
              .show(widget: const Center(child: CircularProgressIndicator()));
          orderResponse(type, tk2.text)
              .then((value) => null)
              .whenComplete(() => {context.loaderOverlay.hide()});
        } else {
          print('Algo salio mal');
        }
        break;
      case 3:
        print('Tres');
        if (_SocioIDformKey!.currentState!.validate()) {
          context.loaderOverlay
              .show(widget: const Center(child: CircularProgressIndicator()));
          orderResponse(type, tk3.text)
              .then((value) => {})
              .whenComplete(() => {context.loaderOverlay.hide()});
        } else {
          print('Algo salio mal');
        }
        break;
    }
  }

  Future odooQuery() async {
    String from = "pos.order";
    List<String> select = [
      "id",
      "name",
      "date_order",
      "amount_total",
      "amount_paid",
      "amount_return",
      "state",
      "pos_reference"
    ];
    List<dynamic> where = ["id", "=", 10];
    String orderBy = "id";
    try {
      final query = await widget.odoo?.query(
        from: from,
        select: select,
        orderBy: orderBy,
        limit: 50,
      );

      for (var c in query!) {}
    } catch (e) {
      print(e);
    }
    return orders;
  }

  Future orderResponse(dynamic type, dynamic id) async {
    String uri = "http://localhost:8069/api23/";
    Response res;

    res = await dio.post(uri, data: {
      "params": {'id': id, 'type_operation': type}
    });

    print(res.data['jsonrpc']);

    for (var c in res.data['results']) {}
  }
}
