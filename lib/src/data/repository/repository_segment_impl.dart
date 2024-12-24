import 'package:dio/dio.dart';
import 'package:strava_client/src/data/repository/client.dart';
import 'package:strava_client/src/domain/model/model.dart';
import 'package:strava_client/src/domain/repository/repository_segment.dart';

class RepositorySegmentImpl extends RepositorySegment {
  @override
  Future<ExplorerResponse> exploreSegments(
      GeoPoint southWestCorner,
      GeoPoint northEastCorner,
      ActivityTypeEnum typeEnum,
      int minClimbingCategory,
      int maxClimbingCategory) {
    var queryParams = {
      "bounds": [
        southWestCorner.lat,
        southWestCorner.lon,
        northEastCorner.lat,
        northEastCorner.lon
      ],
      "activity_type": typeEnum.stringValue(),
      "min_cat": minClimbingCategory,
      "max_cat": maxClimbingCategory
    };
    return ApiClient.getRequest(
        endPoint: "/v3/segments/explore",
        queryParameters: queryParams,
        dataConstructor: (data) =>
            ExplorerResponse.fromJson(Map<String, dynamic>.from(data)));
  }

  @override
  Future<List<SummarySegment>> listStarredSegments(int page, int perPage) {
    return ApiClient.getRequest(
        endPoint: "/v3/segments/starred",
        queryParameters: {"page": page, "per_page": perPage},
        dataConstructor: (data) {
          if (data is List) {
            return data
                .map((e) =>
                    SummarySegment.fromJson(Map<String, dynamic>.from(e)))
                .toList();
          }
          return [];
        });
  }

  @override
  Future<DetailedSegment> getSegment(int segmentId) {
    return ApiClient.getRequest(
        endPoint: "/v3/segments/$segmentId",
        dataConstructor: (data) =>
            DetailedSegment.fromJson(Map<String, dynamic>.from(data)));
  }

  @override
  Future<DetailedSegment> starSegment(int segmentId, bool isStarred) {
    FormData formData = FormData.fromMap({"starred": isStarred});
    return ApiClient.putRequest(
        endPoint: "/v3/segments/$segmentId/starred",
        postBody: formData,
        dataConstructor: (data) =>
            DetailedSegment.fromJson(Map<String, dynamic>.from(data)));
  }

  @override
  Future<SegmentLeaderboard> getLeaderBoard(SegmentLeaderboardRequest request) {
    return ApiClient.getRequest(
        endPoint: "/v3/segments/${request.segmentId}/leaderboard",
        queryParameters: request.toJson(),
        dataConstructor: (data) =>
            SegmentLeaderboard.fromJson(Map<String, dynamic>.from(data)));
  }
}
