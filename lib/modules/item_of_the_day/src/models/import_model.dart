class ImportModel {
  final List<String> order;
  final DateTime startDate;

  ImportModel({
    required this.order,
    required this.startDate,
  });

  factory ImportModel.fromJson(Map<String, dynamic> json) => ImportModel(
        order: List<String>.from(json['order']).map((item) => item.replaceAll(' ', '').toLowerCase()).toList(),
        startDate: DateTime.fromMillisecondsSinceEpoch(json['startDate'], isUtc: true),
      );

  Map<String, dynamic> toJson() => {
        'order': List<dynamic>.from(order.map((item) => item)),
        'startDate': startDate,
      };

  @override
  String toString() => toJson().toString();
}
