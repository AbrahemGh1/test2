class TherapistApi {
  // The URL for fetching the therapist list
  static const String therapistListUrl =
      'https://5de4c8beaf9e4acca186c9f874ea3fd5.api.mockbin.io/';
//https://5de4c8beaf9e4acca186c9f874ea3fd5.api.mockbin.io/
//https://6616ee1ecbb944d38f9c2b10936789ad.api.mockbin.io/
  // You can add more endpoints or constants here if needed in the future
  // For example, if you had an endpoint to get details of a specific therapist:
  // static const String therapistDetailsUrl = 'https://api.example.com/therapists/{id}';

  // Optionally, you can add a method to build the full URL for a therapist's details
  // If you plan to use a dynamic parameter, like therapist id
  static String getTherapistDetailsUrl(String id) {
    return 'https://api.example.com/therapists/$id';
  }
}
