import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/listing.dart';

class ListingCard extends StatelessWidget {
  final Listing listing;
  final VoidCallback onTap;

  const ListingCard({
    Key? key,
    required this.listing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(width * 0.03),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: listing.pictures.isNotEmpty
                      ? listing.pictures.first
                      : "https://via.placeholder.com/100",
                  width: width * 0.28,
                  height: height * 0.12,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: width * 0.28,
                    height: height * 0.12,
                    color: const Color(0xFF1E88E5),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: width * 0.28,
                    height: height * 0.12,
                    color: const Color(0xFF1E88E5),
                    child: const Icon(Icons.home, size: 40, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(width: width * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listing.formattedPrice,
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.005,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade600,
                            borderRadius: BorderRadius.zero,
                          ),
                          child: Text(
                            listing.idcStatus,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      listing.idcFullAddress,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: height * 0.01),
                    Row(
                      children: [
                        _iconLabel(Icons.bed, "${listing.beds ?? '-'}", width),
                        SizedBox(width: width * 0.04),
                        _iconLabel(Icons.bathtub, "${listing.bathsTotal ?? '-'}", width),
                        SizedBox(width: width * 0.04),
                        _iconLabel(Icons.square_foot, "${listing.sqft ?? '-'} Sqft", width),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconLabel(IconData icon, String text, double width) {
    return Row(
      children: [
        Icon(icon, size: width * 0.035, color: Colors.blueGrey),
        SizedBox(width: width * 0.01),
        Text(
          text,
          style: TextStyle(
            fontSize: width * 0.03,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
