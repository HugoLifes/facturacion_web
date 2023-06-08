import 'package:facturacion_web/src/main_screen/model/query_model.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

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
          profile_view(),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dataStructProfile('Email:', widget.idModel!.email),
                      const SizedBox(
                        height: 10,
                      ),
                      dataStructProfile('Tel:', widget.idModel!.phone),
                      const SizedBox(
                        height: 10,
                      ),
                      dataStructProfile(
                          'Compañia:', widget.idModel!.companyName),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 50, left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dataStructProfile('Funcion:', widget.idModel!.funcion),
                      const SizedBox(
                        height: 10,
                      ),
                      dataStructProfile('Calle:', widget.idModel!.calle),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]));
  }

  Row dataStructProfile(String text, dynamic text2) {
    return Row(
      children: [
        Text(
          '$text',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '$text2',
          style: TextStyle(fontSize: 17),
        ),
      ],
    );
  }

  Row profile_view() {
    return Row(
      children: [
        Flexible(
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.shade300),
            child: const Icon(
              Icons.person,
              size: 55,
              color: primaryColor,
            ),
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 16, left: 20),
                child: Text(
                  widget.idModel!.name!,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 21),
                child: Text(
                  widget.idModel!.rfc!,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
