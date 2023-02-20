import 'package:facturacion_web/src/main_screen/model/query_model.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Ordenes',
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
                    Text('id: ${widget.order![data].id}'),
                    Text('name: ${widget.order![data].name}'),
                    Text('fecha: ${widget.order![data].dateOrder}'),
                    Text('Monto Pagado: '),
                    Text('Monto Total: '),
                    Row(
                      children: [
                        Text('Cambio: '),
                        TextButton(
                            onPressed: () {
                              print('facturado');
                            },
                            child: Text('Facturar'))
                      ],
                    )
                  ]),
            );
          }),
    );
  }
}
