import 'package:strava_flutter/domain/model/model_activity_request_create.dart';
import 'package:strava_flutter/domain/model/model_activity_request_update.dart';
import 'package:strava_flutter/domain/model/model_activity_zone.dart';
import 'package:strava_flutter/domain/model/model_comment.dart';
import 'package:strava_flutter/domain/model/model_detailed_activity.dart';
import 'package:strava_flutter/domain/model/model_lap.dart';
import 'package:strava_flutter/domain/model/model_summary_activity.dart';
import 'package:strava_flutter/domain/model/model_summary_athlete.dart';
import 'package:strava_flutter/domain/model/model_tcx_activities.dart';
import 'package:strava_flutter/domain/repository/repository_activity.dart';

import 'package:xml/xml.dart';

import 'client.dart';

class RepositoryActivityImpl extends RepositoryActivity{
  @override
  Future<DetailedActivity> getActivity(int activityId) {
    return ApiClient.getRequest(endPoint: "/v3/activities/$activityId", dataConstructor: (data)=>DetailedActivity.fromJson(Map<String,dynamic>.from(data)));
  }

  @override
  Future<TCXActivity> getTCXActivity(int activityId) {
    return ApiClient.getRequest(endPoint: "/v3/activities/$activityId/export_tcx", dataConstructor: (data) { 
      final xmlActivities = XmlDocument.parse(data).getElement('TrainingCenterDatabase')?.getElement('Activities');
      if (xmlActivities != null)
      {
        final activities = TCXActivities.fromXml(xmlActivities).activities;
        if (activities != null)
        {
          activities.single;
        }
        else
        {
          TCXActivity();
        }
      }
      return TCXActivity();
    });
  }

  @override
  Future<List<Comment>> listActivityComments(int activityId) {
    return ApiClient.getRequest(endPoint: "/v3/activities/$activityId/comments", dataConstructor: (data){
      if(data is List){
        return data.map((d) => Comment.fromJson(Map<String,dynamic>.from(d))).toList();
      }
      return [];
    });
  }

  @override
  Future<List<SummaryAthlete>> listActivityKudoers(int activityId) {
    return ApiClient.getRequest(endPoint: "/v3/activities/$activityId/comments", dataConstructor: (data){
      if(data is List){
        return data.map((d) => SummaryAthlete.fromJson(Map<String,dynamic>.from(d))).toList();
      }
      return [];
    });
  }

  @override
  Future<List<Lap>> getLapsByActivityId(int activityId) {
    return ApiClient.getRequest(endPoint: "/v3/activities/$activityId/laps", dataConstructor: (data){
      if(data is List){
        return data.map((d) => Lap.fromJson(Map<String,dynamic>.from(d))).toList();
      }
      return [];
    });
  }

  @override
  Future<List<SummaryActivity>> listLoggedInAthleteActivities(DateTime before, DateTime after, int page, int perPage) {
    var queryParams = {
      "before":before.millisecondsSinceEpoch / 1000,
      "after":after.millisecondsSinceEpoch / 1000,
      "page":page,
      "per_page":perPage
    };
    return ApiClient.getRequest(endPoint: "/v3/athlete/activities",queryParameters: queryParams, dataConstructor: (data){
      if(data is List){
        return data.map((d) => SummaryActivity.fromJson(Map<String,dynamic>.from(d))).toList();
      }
      return [];
    });
  }

  @override
  Future<List<ActivityZone>> getActivityZones(int activityId) {
    return ApiClient.getRequest(endPoint: "/v3/activities/$activityId/zones", dataConstructor: (data){
      if(data is List){
        return data.map((d) => ActivityZone.fromJson(Map<String,dynamic>.from(d))).toList();
      }
      return [];
    });
  }

  @override
  Future<DetailedActivity> createActivity(CreateActivityRequest request) {
    return ApiClient.postRequest(endPoint: "/v3/activities",postBody: request.toJson(), dataConstructor: (data)=>DetailedActivity.fromJson(Map<String,dynamic>.from(data)));
  }

  @override
  Future<DetailedActivity> updateActivity(int activityId, UpdateActivityRequest request) {
    return ApiClient.putRequest(endPoint: "/v3/activities/$activityId", dataConstructor: (data)=>DetailedActivity.fromJson(Map<String,dynamic>.from(data)));
  }

}