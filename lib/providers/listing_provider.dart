import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/listing_response.dart';
import '../models/listing.dart';

enum DataState { loading, loaded, error }

class ListingProvider with ChangeNotifier {
  DataState _state = DataState.loading;
  List<Listing> _listings = [];
  List<Listing> _filteredListings = [];
  String _searchQuery = '';
  String? _errorMessage;

  DataState get state => _state;
  List<Listing> get listings => _listings;
  List<Listing> get filteredListings => _filteredListings;
  String get searchQuery => _searchQuery;
  String? get errorMessage => _errorMessage;

  ListingProvider() {
    loadListings();
  }

  Future<void> loadListings() async {
    try {
      _state = DataState.loading;
      notifyListeners();

      final String jsonString = await rootBundle.loadString('assets/listings.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final response = ListingResponse.fromJson(jsonData);
      _listings = response.data;
      _filteredListings = _listings;

      _state = DataState.loaded;
      notifyListeners();
    } catch (e) {
      _state = DataState.error;
      _errorMessage = 'Failed to load listings: $e';
      notifyListeners();
    }
  }

  void searchListings(String query) {
    _searchQuery = query;

    if (query.isEmpty) {
      _filteredListings = _listings;
    } else {
      _filteredListings = _listings
          .where((listing) => listing.matchesSearch(query))
          .toList();
    }

    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredListings = _listings;
    notifyListeners();
  }

  Listing? getListingById(int cmncmnkey) {
    try {
      return _listings.firstWhere((listing) => listing.cmncmnkey == cmncmnkey);
    } catch (e) {
      return null;
    }
  }
}