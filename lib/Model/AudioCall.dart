class CallModel {
  String? id;
  String? callerName;
  String? callerPic;
  String? callerUid;
  String? callerEmail;
  String? receiverName;
  String? receiverPic;
  String? receiverUid;
  String? receiverEmail;
  String? status;
  String? type;
  String? time;
  String? timestamp;

  CallModel({
    this.id,
    this.callerName,
    this.callerPic,
    this.callerUid,
    this.callerEmail,
    this.receiverName,
    this.receiverPic,
    this.receiverUid,
    this.receiverEmail,
    this.status,
    this.type,
    this.time,
    this.timestamp,
  });

  CallModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["callerName"] is String) {
      callerName = json["callerName"];
    }
    if (json["callerPic"] is String) {
      callerPic = json["callerPic"];
    }
    if (json["callerUid"] is String) {
      callerUid = json["callerUid"];
    }
    if (json["callerEmail"] is String) {
      callerEmail = json["callerEmail"];
    }
    if (json["receiverName"] is String) {
      receiverName = json["receiverName"];
    }
    if (json["receiverPic"] is String) {
      receiverPic = json["receiverPic"];
    }
    if (json["receiverUid"] is String) {
      receiverUid = json["receiverUid"];
    }
    if (json["receiverEmail"] is String) {
      receiverEmail = json["receiverEmail"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["time"] is String) {
      time = json["time"];
    }
    if (json["timestamp"] is String) {
      timestamp = json["timestamp"];
    }
  }

  static List<CallModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(CallModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["callerName"] = callerName;
    _data["callerPic"] = callerPic;
    _data["callerUid"] = callerUid;
    _data["callerEmail"] = callerEmail;
    _data["receiverName"] = receiverName;
    _data["receiverPic"] = receiverPic;
    _data["receiverUid"] = receiverUid;
    _data["receiverEmail"] = receiverEmail;
    _data["status"] = status;
    _data["type"] = type;
    _data["time"] = time;
    _data["timestamp"] = timestamp;
    return _data;
  }
}
