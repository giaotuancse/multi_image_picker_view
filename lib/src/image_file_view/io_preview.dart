import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/src/image_file_view/error_preview.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../image_file.dart';

class ImageFileView extends StatelessWidget {
  final ImageFile imageFile;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final ImageErrorWidgetBuilder? errorBuilder;

  const ImageFileView(
      {super.key,
      required this.imageFile,
      this.fit = BoxFit.cover,
      this.borderRadius,
      this.errorBuilder,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.background,
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
      child: imageFile.isNetworkImage
          ? CachedNetworkImage(
              imageUrl: imageFile.path!,
              progressIndicatorBuilder: (context, url, downloadProgress) => Shimmer(
                    color: Colors.grey,
                    duration: const Duration(seconds: 3),
                    interval: const Duration(seconds: 0),
                    enabled: true,
                    direction: const ShimmerDirection.fromLTRB(),
                    child: Container(
                      height: 150,
                    ),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover)
          : Image.file(
              File(imageFile.path!),
              fit: BoxFit.cover,
              errorBuilder: errorBuilder ??
                  (context, error, stackTrace) {
                    return ErrorPreview(imageFile: imageFile);
                  },
            ),
    );
  }
}
