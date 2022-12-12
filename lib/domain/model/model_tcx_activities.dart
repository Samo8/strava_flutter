import 'package:xml/xml.dart';

class TCXActivities {
  List<TCXActivity>? activities;
 
  TCXActivities(
      {this.activities,});
  
  TCXActivities.fromJson(dynamic json) {   
    if (json['activities'] != null) {
      activities = [];
      json['activities'].forEach((v) {
        activities?.add(TCXActivity.fromJson(v));
      });
    } 
  }

  TCXActivities.fromXml(XmlElement xml) {  
    var xmlActivitiesList = xml.findElements('Activity'); 
    if (xmlActivitiesList != null) {
      activities = [];
      xmlActivitiesList.forEach((v) {
        activities?.add(TCXActivity.fromXml(v));
      });
    } 
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    if (activities != null) {
      jsonMap['activities'] =
          activities?.map((v) => v.toJson()).toList();
    }
    return jsonMap;
  }
}

class TCXActivity {
 
  String? id;
  String? sport;
  List<TCXLap>? laps;


  TCXActivity(
      {this.id,
      this.sport,
      this.laps,
      });

  TCXActivity.fromJson(dynamic json) {
    id = json['id'];
    sport = json['sport'];
   
    if (json['laps'] != null) {
      laps = [];
      json['laps'].forEach((v) {
        laps?.add(TCXLap.fromJson(v));
      });
    } 
  }

  TCXActivity.fromXml(XmlElement xml) {

    id = xml.findElements('Id').single.text;
    sport = xml.attributes
      .where((e) => e.name.local == 'Sport')
      .single.value;
   
    var xmlLapList = xml.findElements('Lap'); 
    if (xmlLapList != null) {
      laps = [];
      xmlLapList.forEach((v) {
        laps?.add(TCXLap.fromXml(v));
      });
    } 
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    jsonMap['id'] = id;
    jsonMap['sport'] = sport;
    if (laps != null) {
      jsonMap['laps'] =
          laps?.map((v) => v.toJson()).toList();
    }
    return jsonMap;
  }
}

class TCXLap {
 
  DateTime? startTime;
  double? totalTimeSeconds;
  double? distanceMeters;
  TCXHeartRateBpm? averageHeartRateBpm;
  List<TCXTrack>? tracks;


  TCXLap({
      this.startTime,
      this.totalTimeSeconds,
      this.distanceMeters,
      this.averageHeartRateBpm,
      this.tracks
      });

  TCXLap.fromXml(XmlElement xml) {

    startTime = DateTime.parse(xml.attributes
      .where((e) => e.name.local == 'StartTime')
      .single.value);

    totalTimeSeconds = double.parse(xml.findElements('TotalTimeSeconds').single.text);
    distanceMeters = double.parse(xml.findElements('DistanceMeters').single.text);

    var xmlAHR = xml.getElement('AverageHeartRateBpm'); 
    if (xmlAHR != null) {
      averageHeartRateBpm = TCXHeartRateBpm.fromXml(xmlAHR);
    }

    var xmlTrackList = xml.findElements('Track'); 
    if (xmlTrackList != null) {
      tracks = [];
      xmlTrackList.forEach((v) {
        tracks?.add(TCXTrack.fromXml(v));
      });
    } 
  }

  TCXLap.fromJson(dynamic json) {
    startTime = json['startTime'];
    totalTimeSeconds = json['totalTimeSeconds'];
    distanceMeters = json['distanceMeters'];

    if (json['averageHeartRateBpm'] != null) {
        averageHeartRateBpm = TCXHeartRateBpm.fromJson(json['averageHeartRateBpm']);
    }
    if (json['tracks'] != null) {
      tracks = [];
      json['tracks'].forEach((v) {
        tracks?.add(TCXTrack.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    jsonMap['startTime'] = startTime;
    jsonMap['totalTimeSeconds'] = totalTimeSeconds;
    jsonMap['distanceMeters'] = distanceMeters;
    jsonMap['averageHeartRateBpm'] = averageHeartRateBpm?.toJson();
    if (tracks != null) {
      jsonMap['tracks'] =
          tracks?.map((v) => v.toJson()).toList();
    }
    return jsonMap;
  }
}

class TCXTrack {
 
  List<TCXTrackPoint>?  trackPoints;

  TCXTrack(
      {this.trackPoints,});

  TCXTrack.fromXml(XmlElement xml) {   
    var xmlTrackPointsList = xml.findElements('Trackpoint'); 
    if (xmlTrackPointsList != null) {
      trackPoints = [];
      xmlTrackPointsList.forEach((v) {
        trackPoints?.add(TCXTrackPoint.fromXml(v));
      });
    } 
  }

  TCXTrack.fromJson(dynamic json) {
   
    if (json['trackPoints'] != null) {
      trackPoints = [];
      json['trackPoints'].forEach((v) {
        trackPoints?.add(TCXTrackPoint.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    if (trackPoints != null) {
      jsonMap['trackPoints'] =
          trackPoints?.map((v) => v.toJson()).toList();
    }
    return jsonMap;
  }
}

class TCXTrackPoint {
 
  DateTime?  time;
  TCXPosition? position;
  double? altitudeMeters;
  double? distanceMeters;
  TCXHeartRateBpm? heartRateBpm;

  TCXTrackPoint(
      {this.time,
      this.position,
      this.altitudeMeters,
      this.distanceMeters,
      this.heartRateBpm});

  TCXTrackPoint.fromXml(XmlElement xml) {

    time = DateTime.parse(xml.findElements('Time').single.text);

    var xmlPosition = xml.getElement('Position'); 
    if (xmlPosition != null) {
      position = TCXPosition.fromXml(xmlPosition);
    }

    altitudeMeters = double.parse(xml.findElements('AltitudeMeters').single.text);
    distanceMeters = double.parse(xml.findElements('DistanceMeters').single.text);

    var xmlHR = xml.getElement('HeartRateBpm'); 
    if (xmlHR != null) {
      heartRateBpm = TCXHeartRateBpm.fromXml(xmlHR);
    }
  }

  TCXTrackPoint.fromJson(dynamic json) {
    time = json['time'];
    if (json['position'] != null) {
      position = TCXPosition.fromJson(json['position']);
    }
    altitudeMeters = json['altitudeMeters'];
    distanceMeters = json['distanceMeters'];
    if (json['heartRateBpm'] != null) {
      heartRateBpm = TCXHeartRateBpm.fromJson(json['heartRateBpm']);
    }
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    jsonMap['time'] = time;
    if (position != null) {
      jsonMap['position']  = position?.toJson();
    }
    jsonMap['altitudeMeters'] = altitudeMeters;
    jsonMap['distanceMeters'] = distanceMeters;
    if (heartRateBpm != null) {
      jsonMap['heartRateBpm']  = heartRateBpm?.toJson();
    }
    return jsonMap;
  }
}

class TCXPosition {
 
  double? latitudeDegrees;
  double? longitudeDegrees;

  TCXPosition({
      this.latitudeDegrees,
      this.longitudeDegrees,
  });

  TCXPosition.fromXml(XmlElement xml) {
    latitudeDegrees = double.parse(xml.findElements('LatitudeDegrees').single.text);
    longitudeDegrees = double.parse(xml.findElements('LongitudeDegrees').single.text);
  }

  TCXPosition.fromJson(dynamic json) {
    latitudeDegrees = json['latitudeDegrees'];
    longitudeDegrees = json['longitudeDegrees'];
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    jsonMap['latitudeDegrees'] = latitudeDegrees;
    jsonMap['longitudeDegrees'] = longitudeDegrees;
    return jsonMap;
  }
}

class TCXHeartRateBpm {
 
  double? value;

  TCXHeartRateBpm({
      this.value,
  });

  TCXHeartRateBpm.fromXml(XmlElement xml) {
    if(xml.getElement('Value') != null)
    {
      value = double.parse(xml.getElement('Value')!.text);
    }
  }

  TCXHeartRateBpm.fromJson(dynamic json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    jsonMap['value'] = value;
    return jsonMap;
  }
}