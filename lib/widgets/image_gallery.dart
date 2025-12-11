import 'package:flutter/material.dart'
    hide CarouselController;
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:cached_network_image/cached_network_image.dart';

class ImageGallery extends StatefulWidget {
  final List<String> images;
  final double height;

  const ImageGallery({
    Key? key,
    required this.images,
    this.height = 300,
  }) : super(key: key);

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = widget.height;

    if (widget.images.isEmpty) {
      return Container(
        height: height,
        width: width,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.home, size: 80, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: [
        carousel.CarouselSlider.builder(
          itemCount: widget.images.length,
          options: carousel.CarouselOptions(
            height: height,
            viewportFraction: 1.0,
            autoPlay: widget.images.length > 1,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: CachedNetworkImage(
                imageUrl: widget.images[index],
                width: width,
                height: height,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: width,
                  height: height,
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          },
        ),

        if (widget.images.length > 1) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.images.asMap().entries.map((entry) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.blue
                      : Colors.grey[300],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 6),
          Text(
            "${_currentIndex + 1} / ${widget.images.length}",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ]
      ],
    );
  }
}
