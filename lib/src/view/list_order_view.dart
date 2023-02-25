import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../main.dart';
import '../main_screen/model/query_model.dart';

class OrderCards extends StatelessWidget {
  OrderCards({super.key, this.idmodel, this.order, required this.controller});
  final SidebarXController controller;
  List<OrderM>? order = [];
  IdModel? idmodel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          switch (controller.selectedIndex) {
            case 0:
              return buildView(size, theme);
            case 1:
              return Text(
                'Order Status',
                style: theme.textTheme.headlineSmall,
              );
            case 2:
              return Text(
                'Prefil',
                style: theme.textTheme.headlineSmall,
              );
            default:
              return Text(
                'Not Found Page',
                style: theme.textTheme.headlineSmall,
              );
          }
        });
  }

  GridView buildView(Size size, ThemeData theme) {
    return GridView.builder(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        itemCount: order!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size.width > 800
              ? size.width > 900
                  ? 3
                  : 2
              : 1,
          childAspectRatio: size.width > 800
              ? size.width > 900
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
                color: canvasColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 5, offset: Offset(0, 5))
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
                        '${order![data].id}',
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
                        '${order![data].name}',
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
                        '${order![data].dateOrder}',
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
                        '${order![data].montoPagado}',
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
                        '${order![data].cambio!.toStringAsFixed(1)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ]),
          );
        });
  }
}
