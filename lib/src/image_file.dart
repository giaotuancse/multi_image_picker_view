import 'dart:typed_data';

/// Store the image data and other information.
class ImageFile {
  final String key;
  final String name;
  final String extension;
  final Uint8List? bytes;
  final String? path;
  final bool isNetworkImage; // determine

  /// returns true if image has path. (For web path is not available)
  bool get hasPath => path != null;

  /// returns size of bytes if image has bytes, else 0.
  int get size => bytes?.length ?? 0;

  ImageFile(this.key,
      {required this.name, required this.extension, this.bytes, this.path, this.isNetworkImage = false});

  List<Object?> get props => [path, bytes];

  @override
  String toString() {
    return '''{
      'key': $key,
      'name': $name,
      'extension': $extension,
      'bytes': ${bytes?.length},
      'path': $path
    }''';
  }
}
