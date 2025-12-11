import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/listing_provider.dart';
import '../widgets/SearchField.dart';
import '../widgets/listing_card.dart';
import '../widgets/loading_widget.dart';
import 'detail_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final provider = Provider.of<ListingProvider>(context, listen: false);
    provider.searchListings(_searchController.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListingProvider>(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.09),
        child: Container(
          padding: EdgeInsets.only(top: height * 0.015),
          color: Colors.white,
          child: AppBar(
            backgroundColor: const Color(0xFF1E88E5),
            elevation: 2,
            centerTitle: true,

            title: _isSearching
                ? _buildSearchField()
                : const Text(
              "Listings",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            actions: [
              IconButton(
                icon: Icon(
                  _isSearching ? Icons.close : Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (_isSearching) {
                      _searchController.clear();
                      provider.clearSearch();
                    }
                    _isSearching = !_isSearching;
                  });
                },
              )
            ],
          ),
        ),
      ),

      body: _buildBody(provider),
    );
  }

  Widget _buildSearchField() {
    return SearchField(controller: _searchController);
  }

  Widget _buildBody(ListingProvider provider) {
    switch (provider.state) {
      case DataState.loading:
        return const LoadingWidget();

      case DataState.error:
        return Center(
          child: Text(
            provider.errorMessage ?? "Something went wrong",
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        );

      case DataState.loaded:
        if (provider.filteredListings.isEmpty) {
          return const Center(
            child: Text(
              "No properties found",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        }

        return ListView.builder(
          itemCount: provider.filteredListings.length,
          itemBuilder: (context, index) {
            final listing = provider.filteredListings[index];
            return ListingCard(
              listing: listing,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(listing: listing),
                  ),
                );
              },
            );
          },
        );
    }
  }
}
