import 'package:facturacion_web/main.dart';
import 'package:facturacion_web/src/main_screen/model/query_model.dart';
import 'package:facturacion_web/src/view/list_order_view.dart';
import 'package:facturacion_web/src/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import '../main_screen/model/font_style_model.dart';

class OrderViewList extends StatefulWidget {
  OrderViewList({super.key, this.order, this.idmodel});
  List<OrderM>? order = [];
  IdModel? idmodel;
  @override
  State<OrderViewList> createState() => _OrderViewListState();
}

class _OrderViewListState extends State<OrderViewList> {
  final _controller = SidebarXController(selectedIndex: 0);
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          elevation: 8,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text(
                'Facturado',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              elevation: 6,
              action: SnackBarAction(
                textColor: Colors.white,
                label: 'Cerrar',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ));
          },
          icon: Icon(Icons.receipt),
          label: Row(
            children: const [
              Text(
                'Facturar',
                style: TextStyle(fontSize: 15),
              )
            ],
          )),
      body: Row(
        children: [
          //barra lateral con navegacion
          SideBar(
            controller: _controller,
            idmodel: widget.idmodel,
            order: widget.order,
          ),
          //tarjetas de las ordenes
          Expanded(
              child: OrderCards(
            controller: _controller,
            order: widget.order,
            idmodel: widget.idmodel,
          ))
          //buildView(size),
        ],
      ),
    );
  }
}
