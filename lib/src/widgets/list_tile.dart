import 'package:facturacion_web/main.dart';
import 'package:flutter/material.dart';

import '../main_screen/model/form_model.dart';

class CustomListTile {
  CustomListTile({this.subTitleString, this.titleString, this.okey, this.tk});
  String? titleString;
  String? subTitleString;
  GlobalKey<FormState>? okey = GlobalKey<FormState>();
  TextEditingController? tk = TextEditingController();

  Widget customTile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        textColor: primaryColor,
        title: Text(
          '$titleString',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subTitleString!,
            style: const TextStyle(fontWeight: FontWeight.w400)),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: Form(
              key: okey,
              child: TextFormField(
                controller: tk,
                autofocus: false,
                decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2)),
                    hintText: titleString,
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 18),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: primaryColor,
                    )),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Introduce los datos';
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
