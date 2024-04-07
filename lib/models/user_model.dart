class User {
  final String uid;
  final String? email;
  final String? name;
  final String picture;

  final bool isVerified;

  User(
    this.uid,
    this.email,
    this.name,
    this.picture,
    this.isVerified,
  );
}
