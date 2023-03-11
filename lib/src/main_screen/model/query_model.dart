class IdModel {
  //Modelo que sirve para objetualizar el query
  IdModel(
      {this.id,
      this.name,
      this.companyName,
      this.email,
      this.phone,
      this.rfc,
      this.calle,
      this.funcion});

  int? id;
  String? name;
  dynamic email;
  dynamic phone;
  dynamic companyName;
  String? rfc;
  dynamic funcion;
  dynamic calle;
}

class OrderM {
  OrderM(
      {this.cambio,
      this.dateOrder,
      this.fechaCreacion,
      this.id,
      this.montoPagado,
      this.name,
      this.ref,
      this.socioId,
      this.status});

  int? id;
  String? name;
  DateTime? dateOrder;
  int? socioId;
  String? ref;
  double? montoPagado;
  double? cambio;
  String? status;
  DateTime? fechaCreacion;
}
