import 'package:facturacion_web/src/main_screen/model/query_model.dart';
import 'package:flutter/material.dart';

class DataAccount extends StatefulWidget {
  DataAccount({super.key, this.idModel});
  final IdModel? idModel;
  @override
  State<DataAccount> createState() => _DataAccountState();
}

class _DataAccountState extends State<DataAccount> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(13),
        child: Column(children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.grey),
            child: const Icon(
              Icons.person,
              size: 50,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.idModel!.name!,
              style: TextStyle(fontSize: 30),
            ),
          )
        ]));
  }
}
