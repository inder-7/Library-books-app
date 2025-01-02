class Book {
  final String title;
  final String author;
  final String imageUrl;
  final String ID;

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.ID
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'] ?? 'Unknown',
      author: (json['volumeInfo']['authors'] ?? ['Unknown']).join(', '),
      imageUrl: json['volumeInfo']['imageLinks']?['thumbnail'] ??
          'https://via.placeholder.com/150',
          ID: json['id'] ?? '',
    );
  }
}
