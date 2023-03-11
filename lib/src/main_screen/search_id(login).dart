import 'package:facturacion_web/main.dart';
import 'package:facturacion_web/src/widgets/list_tile.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
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
    debugPrint('${size.width}');
    print('');
    return Scaffold(
      body: LoaderOverlay(
        overlayColor: Colors.grey,
        overlayWidget: const Center(child: CircularProgressIndicator()),
        child: ListView(
          padding: EdgeInsets.only(
            right: size.width < 899
                ? size.width * 0.1
                : size.width > 1200
                    ? size.width * 0.3
                    : size.width * 0.19,
            left: size.width < 899
                ? size.width * 0.1
                : size.width > 1200
                    ? size.width * 0.3
                    : size.width * 0.19,
          ),
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
                        color: Colors.grey, blurRadius: 5, offset: Offset(0, 5))
                  ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: const Text(
                        'Bienvenido',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                    CustomListTile(
                            titleString: 'OrdenID',
                            subTitleString:
                                'Crea tu factura por ID orden de compra',
                            okey: _OrdenIdformKey!,
                            tk: tk)
                        .customTile(),
                    CustomListTile(
                            titleString: 'RFC',
                            subTitleString: 'Crea tus facturas por RFC',
                            okey: _RFCformKey,
                            tk: tk2)
                        .customTile(),
                    CustomListTile(
                            titleString: 'ID Socio',
                            subTitleString: 'Facture con su id de socio',
                            okey: _SocioIDformKey!,
                            tk: tk3)
                        .customTile(),
                    okButton(context)
                  ]),
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
        if (tk.text.isNotEmpty && tk2.text.isNotEmpty && tk3.text.isNotEmpty) {
          showToast(
            'Solo un campo a la vez',
            context: context,
            animation: StyledToastAnimation.scale,
            reverseAnimation: StyledToastAnimation.fade,
            position: StyledToastPosition.center,
            animDuration: Duration(seconds: 1),
            duration: Duration(seconds: 4),
            curve: Curves.elasticOut,
            reverseCurve: Curves.linear,
          );
        } else if (tk.text.isNotEmpty) {
          idConfirmation(context, 1);
        } else if (tk2.text.isNotEmpty) {
          idConfirmation(context, 2);
        } else if (tk3.text.isNotEmpty) {
          idConfirmation(context, 3);
        } else if (tk.text.isEmpty && tk2.text.isEmpty && tk3.text.isEmpty) {
          showToast(
            'Lo sentimos, no puede haber campos vacios',
            context: context,
            animation: StyledToastAnimation.scale,
            reverseAnimation: StyledToastAnimation.fade,
            position: StyledToastPosition.center,
            animDuration: Duration(seconds: 1),
            duration: Duration(seconds: 4),
            curve: Curves.elasticOut,
            reverseCurve: Curves.linear,
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
            color: primaryColor,
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
          context.loaderOverlay.show();
          orderResponse(type, tk.text)
              .then((value) => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OrderViewList(
                                  order: orders,
                                  idmodel: ids,
                                )))
                  })
              .whenComplete(() => {context.loaderOverlay.hide(), tk.clear()});
        } else {
          print('Algo salio mal');
        }

        break;
      case 2:
        print('Dos');
        if (_RFCformKey!.currentState!.validate()) {
          context.loaderOverlay.show();
          orderResponse(type, tk2.text)
              .then((value) => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OrderViewList(
                                  order: orders,
                                  idmodel: ids,
                                )))
                  })
              .whenComplete(() => {context.loaderOverlay.hide(), tk2.clear()});
        } else {
          print('Algo salio mal');
        }
        break;
      case 3:
        print('Tres');
        if (_SocioIDformKey!.currentState!.validate()) {
          context.loaderOverlay.show();
          orderResponse(type, tk3.text)
              .then((value) => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OrderViewList(
                                  order: orders,
                                  idmodel: ids,
                                )))
                  })
              .whenComplete(() => {context.loaderOverlay.hide(), tk3.clear()});
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
    for (var c in res.data['result']) {
      ids = IdModel(
          id: c['socio_id'],
          name: c['name'],
          email: c['email'] == false ? 'No dato' : c['email'],
          phone: c['phone'] == false ? 'No dato' : c['phone'],
          rfc: c['RFC'] == false ? 'No dato' : c['RFC'],
          funcion: c['function'] == false ? 'No dato' : c['function'],
          calle: c['street'] == false ? 'No dato' : c['street'],
          companyName: c['commercial_company_name'] == false
              ? 'No dato'
              : c['commercial_company_name']);

      for (var x in c['order']) {
        orders!.add(OrderM(
            id: x['id'],
            name: x['name'],
            socioId: x['socio_id'],
            dateOrder: DateTime.tryParse(x['date_order']),
            ref: x['pos_reference'],
            montoPagado: x['amount_paid'],
            cambio: x['amount_return'],
            status: x['state'],
            fechaCreacion: DateTime.tryParse(x['create_date'])));
      }
    }
    print(ids!.name);
    print(orders!.first.name);
  }
}
