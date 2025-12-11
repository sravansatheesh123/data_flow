class Listing {
  final String propertyRt;
  final int cmncmnkey;
  final String? listAgentName;
  final String? listAgentOffice;
  final List<String> pictures;
  final String idcmlsNumber;
  final int? sqft;
  final int? beds;
  final String idcRemarks;
  final String idcStatus;
  final double idcListPrice;
  final bool idcDisplayAddress;
  final int mlsPhotoCount;
  final String idcPropertyType;
  final int? bathsTotal;
  final String idcFullAddress;

  Listing({
    required this.propertyRt,
    required this.cmncmnkey,
    this.listAgentName,
    this.listAgentOffice,
    required this.pictures,
    required this.idcmlsNumber,
    this.sqft,
    this.beds,
    required this.idcRemarks,
    required this.idcStatus,
    required this.idcListPrice,
    required this.idcDisplayAddress,
    required this.mlsPhotoCount,
    required this.idcPropertyType,
    this.bathsTotal,
    required this.idcFullAddress,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    List<String> parsePictures(dynamic pictureData) {
      if (pictureData == null) return [];
      if (pictureData is List<dynamic>) {
        return pictureData.map((item) => item.toString()).toList();
      }
      return [];
    }

    return Listing(
      propertyRt: json['PROPERTYRT'] ?? '',
      cmncmnkey: json['CMNCMNKEY'] ?? 0,
      listAgentName: json['LISTAGENTNAME'],
      listAgentOffice: json['LISTAGENTOFFICE'],
      pictures: parsePictures(json['PICTURE']),
      idcmlsNumber: json['IDCMLSNUMBER'] ?? '',
      sqft: json['SQFT'],
      beds: json['BEDS'],
      idcRemarks: json['IDCREMARKS'] ?? '',
      idcStatus: json['IDCSTATUS'] ?? '',
      idcListPrice: (json['IDCLISTPRICE'] ?? 0).toDouble(),
      idcDisplayAddress: json['IDCDISPLAYADDRESS'] ?? false,
      mlsPhotoCount: json['MLSPHOTOCOUNT'] ?? 0,
      idcPropertyType: json['IDCPROPERTYTYPE'] ?? '',
      bathsTotal: json['BATHSTOTAL'],
      idcFullAddress: json['IDCFULLADDRESS'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PROPERTYRT': propertyRt,
      'CMNCMNKEY': cmncmnkey,
      'LISTAGENTNAME': listAgentName,
      'LISTAGENTOFFICE': listAgentOffice,
      'PICTURE': pictures,
      'IDCMLSNUMBER': idcmlsNumber,
      'SQFT': sqft,
      'BEDS': beds,
      'IDCREMARKS': idcRemarks,
      'IDCSTATUS': idcStatus,
      'IDCLISTPRICE': idcListPrice,
      'IDCDISPLAYADDRESS': idcDisplayAddress,
      'MLSPHOTOCOUNT': mlsPhotoCount,
      'IDCPROPERTYTYPE': idcPropertyType,
      'BATHSTOTAL': bathsTotal,
      'IDCFULLADDRESS': idcFullAddress,
    };
  }

  String get formattedPrice {
    if (idcListPrice < 1000) {
      return '\$${idcListPrice.toInt()}';
    } else if (idcListPrice < 1000000) {
      return '\$${(idcListPrice / 1000).toStringAsFixed(0)}K';
    } else {
      return '\$${(idcListPrice / 1000000).toStringAsFixed(2)}M';
    }
  }

  String get shortAddress {
    final parts = idcFullAddress.split(',');
    if (parts.length >= 2) {
      return '${parts[0]}, ${parts[parts.length - 2]}';
    }
    return idcFullAddress;
  }

  bool matchesSearch(String query) {
    if (query.isEmpty) return true;

    final lowercaseQuery = query.toLowerCase();
    return idcFullAddress.toLowerCase().contains(lowercaseQuery) ||
        idcmlsNumber.toLowerCase().contains(lowercaseQuery) ||
        (listAgentName?.toLowerCase().contains(lowercaseQuery) ?? false);
  }
}