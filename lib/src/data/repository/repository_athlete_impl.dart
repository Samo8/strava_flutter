import 'package:strava_client/src/data/repository/client.dart';
import 'package:strava_client/src/domain/model/model.dart';
import 'package:strava_client/src/domain/repository/repository_athlete.dart';

class RepositoryAthleteImpl extends RepositoryAthlete {
  @override
  Future<ActivityStats> getAthleteStats(int athleteId) {
    return ApiClient.getRequest(
        endPoint: "/v3/athletes/$athleteId/stats",
        dataConstructor: (data) => ActivityStats.fromJson(data));
  }

  @override
  Future<DetailedAthlete> getAuthenticatedAthlete() {
    return ApiClient.getRequest<DetailedAthlete>(
        endPoint: "/v3/athlete",
        dataConstructor: (data) {
          return DetailedAthlete.fromJson(data);
        });
  }

  @override
  Future<List<Zones>> getZones() {
    return ApiClient.getRequest<List<Zones>>(
        endPoint: "/v3/athlete/zones",
        dataConstructor: (data) {
          if (data is List) {
            return data
                .map((e) => Zones.fromJson(Map<String, dynamic>.from(e)))
                .toList();
          } else {
            return [];
          }
        });
  }

  @override
  Future<DetailedAthlete> updateAthlete(double weight) {
    return ApiClient.putRequest<DetailedAthlete>(
        endPoint: "/v3/athlete",
        queryParameters: {"weight": weight},
        dataConstructor: (data) => DetailedAthlete.fromJson(data));
  }
}
