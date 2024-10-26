class QuoteRequest {
  final int quantity;
  final double thickness;
  final double price;
  final double broad;
  final double long;
  final double pUnid;
  final double subTotal;
  QuoteRequest(
      {required this.quantity,
      required this.thickness,
      required this.broad,
      required this.price,
      required this.long,
      required this.pUnid,
      required this.subTotal});
  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'quantity': quantity,
      'broad': broad,
      'thickness': thickness,
      'long': long,
      'subtotal': subTotal,
      'pUnid': pUnid,
    };
  }
}
