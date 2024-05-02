require_relative '../json-object'

module ChAttrActionTypes
  T01 = "assign.from.value"
  T02 = "assign.from.self-attr"

  T11 = "assign.from.parent-attr"
  T12 = "assign.from.ancestor-attr"
  T13 = "assign.from.ancestor.child-attr"

  T21 = "assign.from.first-child-attr"
  T22 = "assign.from.child-attr"
  T23 = "assign.from.descendent-attr"

  T51 = "url.file.set-ext-suffix"
  T52 = "url.file.rm-ext-suffix"
  T53 = "url.file.set-name-suffix"
  T54 = "url.file.rm-name-suffix"
  T55 = "url.search.edit"


  T71 = "replace.last-match"
  T72 = "replace.all"

  T91 = "split2list.add"
  T92 = "split2list.remove"


  TYPES = [
    T01, T02,
    T11, T12, T13,
    T21, T22, T23,
    T51, T52, T53, T54, T55,

    T71, T72,
    T91, T92,
  ];
end


class OldChAttr
  include JsonObject
  include ChAttrActionTypes

  required_attr :type, in: TYPES
  required_attr :pick
  required_attr :attr
  optional_attr :subStr, required_if: -> {value_in(:type, T71, T72)}
  optional_attr :newStr, required_if: -> {value_in(:type, T71, T72)}
  optional_attr :tElem,  required_if: -> {value_in(:type, T12, T13, T22, T23)}
  optional_attr :tAttr,  required_if: -> {value_in(:type, T02, T11, T12, T13, T21, T22, T23)}
  optional_attr :value,  required_if: -> {value_in(:type, T01, T91, T92)}
  optional_attr :sep,    required_if: -> {value_in(:type, T51, T52, T53, T54)}
  optional_attr :suffix, required_if: -> {value_in(:type, T51, T53)}
  optional_attr :whiteList #T52, T54
  optional_attr :change   #T55
  optional_attr :delete   #T55

end

# without attribute "pick"
class NewChAttrAction
  include JsonObject
  include ChAttrActionTypes

  required_attr :type, in: TYPES
  required_attr :attr
  optional_attr :subStr, required_if: -> {value_in(:type, T71, T72)}
  optional_attr :newStr, required_if: -> {value_in(:type, T71, T72)}
  optional_attr :tElem,  required_if: -> {value_in(:type, T12, T13, T22, T23)}
  optional_attr :tAttr,  required_if: -> {value_in(:type, T02, T11, T12, T13, T21, T22, T23)}
  optional_attr :value,  required_if: -> {value_in(:type, T01, T91, T92)}
  optional_attr :sep,    required_if: -> {value_in(:type, T51, T52, T53, T54)}
  optional_attr :suffix, required_if: -> {value_in(:type, T51, T53)}
  optional_attr :whiteList #T52, T54
  optional_attr :change   #T55
  optional_attr :delete   #T55
end

class NewChAttr
  include JsonObject
  required_attr :pick
  required_attr :action, optional_collection: true, klass: NewChAttrAction
end

