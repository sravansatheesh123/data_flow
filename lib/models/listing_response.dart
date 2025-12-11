import 'listing.dart';

class ListingResponse {
  final List<Listing> data;

  ListingResponse({required this.data});

  factory ListingResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Listing> listings = dataList.map((item) => Listing.fromJson(item)).toList();

    return ListingResponse(data: listings);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((listing) => listing.toJson()).toList(),
    };
  }
}