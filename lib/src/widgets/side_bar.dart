import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../main.dart';
import '../main_screen/model/query_model.dart';

class SideBar extends StatefulWidget {
  SideBar({super.key, required this.controller, this.idmodel, this.order});
  SidebarXController controller;
  List<OrderM>? order = [];
  IdModel? idmodel;
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: widget.controller,
      theme: SidebarXTheme(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 5))
          ], color: canvasColor, borderRadius: BorderRadius.circular(20)),
          textStyle: const TextStyle(color: colorIcon),
          selectedTextStyle: const TextStyle(color: colorIcon),
          itemDecoration: BoxDecoration(border: Border.all(color: canvasColor)),
          selectedItemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorIcon.withOpacity(0.38)),
              color: selectColor,
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 15)
              ]),
          iconTheme: const IconThemeData(color: unselectColor, size: 20)),
      extendedTheme: const SidebarXTheme(
          width: 200,
          selectedItemTextPadding: EdgeInsets.only(left: 10),
          itemTextPadding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(color: canvasColor, boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 5))
          ]),
          margin: EdgeInsets.only(right: 10)),
      footerDivider: divider,
      headerBuilder: (_, extended) {
        return SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              focusColor: actionColor,
              highlightColor: actionColor,
              splashColor: accentCanvasColor,
              hoverColor: unselectColor.withOpacity(0.10),
              child: BackButton(
                onPressed: () {
                  widget.idmodel = IdModel();
                  widget.order!.clear();
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
      },
      items: [
        SidebarXItem(
            icon: Icons.receipt,
            label: 'Inicio',
            onTap: () {
              debugPrint('Hello');
            }),
        SidebarXItem(icon: Icons.view_column, label: 'Status'),
        SidebarXItem(icon: Icons.person, label: 'Perfil'),
      ],
    );
  }
}
