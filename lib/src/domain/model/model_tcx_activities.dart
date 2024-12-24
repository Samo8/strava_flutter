import 'package:xml/xml.dart';

class TCXActivities {
  List<TCXActivity>? activities;

  TCXActivities({
    this.activities,
  });

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

    activities = [];
    xmlActivitiesList.forEach((v) {
      activities?.add(TCXActivity.fromXml(v));
    });
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    if (activities != null) {
      jsonMap['activities'] = activities?.map((v) => v.toJson()).toList();
    }
    return jsonMap;
  }
}

class TCXActivity {
  String? id;
  String? sport;
  List<TCXLap>? laps;

  TCXActivity({
    this.id,
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
    id = xml.findElements('Id').single.value;
    sport = xml.attributes.where((e) => e.name.local == 'Sport').single.value;

    var xmlLapList = xml.findElements('Lap');
    laps = [];
    xmlLapList.forEach((v) {
      laps?.add(TCXLap.fromXml(v));
    });
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    jsonMap['id'] = id;
    jsonMap['sport'] = sport;
    if (laps != null) {
      jsonMap['laps'] = laps?.map((v) => v.toJson()).toList();
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

  TCXLap({this.startTime, this.totalTimeSeconds, this.distanceMeters, this.averageHeartRateBpm, this.tracks});

  TCXLap.fromXml(XmlElement xml) {
    startTime = DateTime.parse(xml.attributes.where((e) => e.name.local == 'StartTime').single.value);

    final xmlTotalTimeInSeconds = xml.findElements('TotalTimeSeconds').single.value;
    final xmlDistanceInMeters = xml.findElements('DistanceMeters').single.value;

    if (xmlTotalTimeInSeconds != null) totalTimeSeconds = double.tryParse(xmlTotalTimeInSeconds);
    if (xmlDistanceInMeters != null) distanceMeters = double.tryParse(xmlDistanceInMeters);

    var xmlAHR = xml.getElement('AverageHeartRateBpm');
    if (xmlAHR != null) {
      averageHeartRateBpm = TCXHeartRateBpm.fromXml(xmlAHR);
    }

    var xmlTrackList = xml.findElements('Track');
    tracks = [];
    xmlTrackList.forEach((v) {
      tracks?.add(TCXTrack.fromXml(v));
    });
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
      jsonMap['tracks'] = tracks?.map((v) => v.toJson()).toList();
    }
    return jsonMap;
  }
}

class TCXTrack {
  List<TCXTrackPoint>? trackPoints;

  TCXTrack({
    this.trackPoints,
  });

  TCXTrack.fromXml(XmlElement xml) {
    var xmlTrackPointsList = xml.findElements('Trackpoint');
    trackPoints = [];
    xmlTrackPointsList.forEach((v) {
      trackPoints?.add(TCXTrackPoint.fromXml(v));
    });
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
      jsonMap['trackPoints'] = trackPoints?.map((v) => v.toJson()).toList();
    }
    return jsonMap;
  }
}

class TCXTrackPoint {
  DateTime? time;
  TCXPosition? position;
  double? altitudeMeters;
  double? distanceMeters;
  TCXHeartRateBpm? heartRateBpm;

  TCXTrackPoint({this.time, this.position, this.altitudeMeters, this.distanceMeters, this.heartRateBpm});

  TCXTrackPoint.fromXml(XmlElement xml) {
    final timeValue = xml.findElements('Time').single.value;
    if (timeValue != null) {
      time = DateTime.tryParse(timeValue);
    }

    var xmlPosition = xml.getElement('Position');
    if (xmlPosition != null) {
      position = TCXPosition.fromXml(xmlPosition);
    }

    final xmlAltitudeMeters = xml.findElements('AltitudeMeters').single.value;
    final xmlDistanceMeters = xml.findElements('DistanceMeters').single.value;

    if (xmlAltitudeMeters != null) altitudeMeters = double.parse(xmlAltitudeMeters);
    if (xmlDistanceMeters != null) distanceMeters = double.parse(xmlDistanceMeters);

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
      jsonMap['position'] = position?.toJson();
    }
    jsonMap['altitudeMeters'] = altitudeMeters;
    jsonMap['distanceMeters'] = distanceMeters;
    if (heartRateBpm != null) {
      jsonMap['heartRateBpm'] = heartRateBpm?.toJson();
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
    final xmlLatitudeDegrees = xml.findElements('LatitudeDegrees').single.value;
    final xmlLongitudeDegrees = xml.findElements('LongitudeDegrees').single.value;

    if (xmlLatitudeDegrees != null) latitudeDegrees = double.parse(xmlLatitudeDegrees);
    if (xmlLongitudeDegrees != null) longitudeDegrees = double.parse(xmlLongitudeDegrees);
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
    final xmlValue = xml.getElement('Value')?.value;
    if (xmlValue != null) value = double.parse(xmlValue);
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
