import 'package:strava_client/src/domain/model/model.dart';

/// Repository managing all API calls related to `segments`.
abstract class RepositorySegment {
  /// Returns the top 10 segments matching a specific query as a
  /// [ExplorerResponse].
  ///
  /// The rectangular boundary for the search is defined by [southWestCorner]
  /// and [northEastCorner], two [GeoPoint]s. [typeEnum] defines the desired
  /// activity type.
  ///
  /// {@macro fault_management}
  Future<ExplorerResponse> exploreSegments(
    GeoPoint southWestCorner,
    GeoPoint northEastCorner,
    ActivityTypeEnum typeEnum,
    int minClimbingCategory,
    int maxClimbingCategory,
  );

  /// Returns a list of the authenticated `athlete`'s starred [SummarySegment]s.
  ///
  /// `Private` segments are filtered out unless requested by a token with
  /// [AuthenticationScope.read_all].
  ///
  /// {@macro fault_management}
  Future<List<SummarySegment>> listStarredSegments(int page, int perPage);

  /// Returns a the [DetailedSegment] corresponding to this [segmentId].
  ///
  /// [AuthenticationScope.read_all] required in order to retrieve
  /// `athlete-specific` segment information, or to retrieve `private` segments.
  ///
  /// {@macro fault_management}
  Future<DetailedSegment> getSegment(int segmentId);

  /// Stars/Unstars the given segment from [segmentId] and returns it as a
  /// [DetailedSegment].
  ///
  /// Requires [AuthenticationScope.profile_write].
  ///
  /// If [isStarred], stars the `segment`, else unstar it.
  ///
  /// {@macro fault_management}
  Future<DetailedSegment> starSegment(int segmentId, bool isStarred);

  Future<SegmentLeaderboard> getLeaderBoard(SegmentLeaderboardRequest request);
}
