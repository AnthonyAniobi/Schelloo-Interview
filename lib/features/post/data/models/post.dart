// {
//     "userId": 8,
//     "id": 74,
//     "title": "enim unde ratione doloribus quas enim ut sit sapiente",
//     "body": "odit qui et et necessitatibus sint veniam\nmollitia amet doloremque molestiae commodi similique magnam et quam\nblanditiis est itaque\nquo et tenetur ratione occaecati molestiae tempora"
//   },

class Post {
  static const _userIdKey = "userId";
  static const _idKey = "id";
  static const _titleKey = "title";
  static const _bodyKey = "body";

  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json[_userIdKey],
      id: json[_idKey],
      title: json[_titleKey],
      body: json[_bodyKey],
    );
  }

  Map<String, dynamic> toJson() => {
        _userIdKey: userId,
        _idKey: id,
        _titleKey: title,
        _bodyKey: body,
      };
}
