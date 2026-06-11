class User {
  String username;
  String password;
  User({required this.username, required this.password});
}

class Product {
  String name;
  String description;
  double price;
  int quantity;
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });
}