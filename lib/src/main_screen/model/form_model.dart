import 'package:facturacion_web/main.dart';
import 'package:flutter/material.dart';

class FormModel {
  FormModel({this.text, this.key, this.token});

  String? text;
  GlobalKey<FormState>? key = GlobalKey<FormState>();
  TextEditingController? token;

  Widget idForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      child: Form(
        key: key,
        child: TextFormField(
          controller: token,
          autofocus: false,
          decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2)),
              hintText: text,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
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
    );
  }
}
