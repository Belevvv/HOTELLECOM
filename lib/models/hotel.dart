class Hotel {
  final String name;
  final String address;
  final double price;
  final double star;
  final String description;
  final Map<String, dynamic> more;

  Hotel({
    required this.name,
    required this.address,
    required this.price,
    required this.star,
    required this.description,
    required this.more,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'price': price,
      'star': star,
      'description': description,
      'more': more,
    };
  }


  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      name: map['name'],
      address: map['address'],
      price: map['price'],
      star: map['star'],
      description: map['description'],
      more: Map<String, dynamic>.from(map['more']),
    );
  }
}