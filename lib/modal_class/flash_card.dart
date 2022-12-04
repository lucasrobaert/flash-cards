class FlashCard {
  int? _id;
  String _type = "";
  String _front = "";
  String _back = "";
  bool _known = false;

  FlashCard(this._back, this._front, this._type, this._known);

  FlashCard.withId(this._id, this._back, this._front, this._type, this._known);

  int? get id => _id;

  String get front => _front;

  String get back => _back;

  String get type => _type;

  bool get known => _known;

  set front(String newTitle) {
    if (newTitle.length <= 255) {
      _front = newTitle;
    }
  }

  set back(String newDescription) {
    if (newDescription.length <= 255) {
      _back = newDescription;
    }
  }

  set type(String newType) {
    _type = newType;
  }

  set known(bool newknown) {
    _known = newknown;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['front'] = _front;
    map['back'] = _back;
    map['known'] = _known;
    map['type'] = _type;

    return map;
  }

  // Extract a Note object from a Map object
  FlashCard.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _front = map['front'];
    _back = map['back'];
    _known = map['known'] == 1;
    _type = map['type'];
  }
}
