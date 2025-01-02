
class BookDetail {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final String publishDate;
  final String description;

  BookDetail({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.publishDate,
    required this.description,
  });
factory BookDetail.fromJson(Map<String, dynamic> json) {
    // Extracting values from the correct JSON structure
    return BookDetail(
      id: json['id'] ?? 'Unknown ID',  // Default value if key doesn't exist
      title: json['volumeInfo']['title'] ?? 'No title available',
      author: (json['volumeInfo']['authors'] != null && json['volumeInfo']['authors'].isNotEmpty)
          ? (json['volumeInfo']['authors'] as List).join(', ')
          : 'Unknown author',
      imageUrl: json['volumeInfo']['imageLinks'] != null
          ? json['volumeInfo']['imageLinks']['thumbnail'] ?? 'https://via.placeholder.com/150'
          : 'https://via.placeholder.com/150',
      publishDate: json['volumeInfo']['publishedDate'] ?? 'Unknown publish date',
      description: json['volumeInfo']['description'] ?? 'No description available',
    );
  }
}