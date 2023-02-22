import 'package:facturacion_web/src/main_screen/model/query_model.dart';
import 'package:flutter/material.dart';

import '../main_screen/model/font_style_model.dart';

class OrderViewList extends StatefulWidget {
  OrderViewList({super.key, this.order, this.idmodel});
  List<OrderM>? order = [];
  IdModel? idmodel;
  @override
  State<OrderViewList> createState() => _OrderViewListState();
}

class _OrderViewListState extends State<OrderViewList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          elevation: 8,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Facturado'),
              elevation: 6,
              action: SnackBarAction(
                label: 'Cerrar',
                onPressed: () {},
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
      appBar: AppBar(
        elevation: 7,
        leading: BackButton(onPressed: () {
          widget.idmodel = IdModel();
          widget.order!.clear();
          Navigator.pop(context);
        }),
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          '${widget.idmodel!.name}',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
          itemCount: widget.order!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: size.width > 700
                ? size.width > 1000
                    ? 3
                    : 2
                : 1,
            childAspectRatio: size.width > 700
                ? size.width > 1000
                    ? size.width / 500
                    : size.width / 350
                : size.width / 255,
            crossAxisSpacing: 25,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (_, int data) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'ID Socio:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${widget.order![data].id}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Nombre:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${widget.order![data].name}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Fecha:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${widget.order![data].dateOrder}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Monto Pagado:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${widget.order![data].montoPagado}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Cambio:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${widget.order![data].cambio}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ]),
            );
          }),
    );
  }
}

class CardData {
  CardData({this.title});
  String? title;
}
