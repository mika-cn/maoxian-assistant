require_relative '../json-object'

class ChAttrAction
  include JsonObject

  T01 = "assign.from.value"
  T02 = "assign.from.self-attr"

  T11 = "assign.from.parent-attr"
  T12 = "assign.from.ancestor-attr"
  T13 = "assign.from.ancestor.child-attr"

  T21 = "assign.from.first-child-attr"
  T22 = "assign.from.child-attr"
  T23 = "assign.from.descendent-attr"

  T71 = "replace.last-match"
  T72 = "replace.all"

  T91 = "split2list.add"
  T92 = "split2list.remove"


  TYPES = [
    T01, T02,
    T11, T12, T13,
    T21, T22, T23,

    T71, T72,
    T91, T92,
  ];

  required_attr :type, in: TYPES
  required_attr :pick
  required_attr :attr
  required_attr :subStr,    if: -> {value_in(:type, T71, T72)}
  required_attr :newStr,    if: -> {value_in(:type, T71, T72)}
  required_attr :tElem,     if: -> {value_in(:type, T12, T13, T22, T23)}
  required_attr :tAttr,     if: -> {value_in(:type, T02, T11, T12, T13, T21, T22, T23)}
  required_attr :value,     if: -> {value_in(:type, T01, T91, T92)}
  optional_attr :sep,       if: -> {value_in(:type, T91, T92)}

end

