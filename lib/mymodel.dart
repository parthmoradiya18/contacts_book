class model {
  String? id;
  String? name;
  String? contact;
  String? image;

  model({this.id, this.name, this.contact, this.image});

  model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['image'] = this.image;
    return data;
  }

  @override
  String toString() {
    return 'model{id: $id, name: $name, contact: $contact, image: $image}';
  }
}
