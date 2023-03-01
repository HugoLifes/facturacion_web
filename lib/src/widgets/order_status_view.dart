import 'package:facturacion_web/main.dart';
import 'package:flutter/material.dart';

import '../main_screen/model/query_model.dart';

class OrderStatusView extends StatefulWidget {
  OrderStatusView({super.key, this.order, this.idmodel});
  List<OrderM>? order;
  IdModel? idmodel;
  @override
  State<OrderStatusView> createState() => _OrderStatusViewState();
}

class _OrderStatusViewState extends State<OrderStatusView> {
  dynamic dataColumn = {"ID", "Nombre", "Fecha", "Referencia"};
  bool selectAll = false;
  List addOrders = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: size.width * 0.1,
              onSelectAll: (value) {
                if (value!) {
                  setState(() {
                    selectAll = true;
                  });
                } else if (selectAll == true) {
                  setState(() {
                    selectAll = false;
                  });
                }
              },
              sortAscending: true,
              dataRowHeight: 43,
              columns: [
                ...dataColumn!
                    .map((e) => DataColumn(
                            label: Text(
                          e,
                          style: largeText.copyWith(fontSize: 18),
                        )))
                    .toList(),
                DataColumn(
                    label: Text(
                  'Status',
                  style: largeText.copyWith(
                    fontSize: 18,
                  ),
                ))
              ],
              rows: [
                ...widget.order!.map((e) => DataRow(
                        selected: selectAll == true
                            ? selectAll
                            : addOrders.contains(e),
                        onSelectChanged: (v) {
                          if (v!) {
                            setState(() {
                              addOrders.add(e);
                            });
                          } else {
                            setState(() {
                              addOrders.remove(e);
                            });
                          }
                        },
                        cells: [
                          DataCell(
                              Text(
                                e.id.toString(),
                                style: rowText,
                                textAlign: TextAlign.center,
                              ),
                              placeholder: false),
                          DataCell(Text(
                            e.name.toString(),
                            style: rowText,
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Text(
                            "${e.dateOrder!.day}/0${e.dateOrder!.month}/${e.dateOrder!.year}",
                            style: rowText,
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Text(
                            e.ref.toString(),
                            style: rowText,
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Container(
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green),
                            child: Text(
                              e.status.toString(),
                              style: rowText,
                              textAlign: TextAlign.center,
                            ),
                          ))
                        ])),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
