require_relative 'json-object'

class MxPlanAction
  include JsonObject
  TYPES = [ "__IGNORE_ME__",

    "assign.from.self-attr",
    "assign.from.parent-attr",
    "assign.from.ancestor-attr",
    "assign.from.ancestor.child-attr",

    "replace.last-match",
    "replace.all",

    "split2list.add",
    "split2list.remove",
  ]

  required_attr :type, in: TYPES
  required_attr :pick
  required_attr :attr
  required_attr :subStr,    if: -> {TYPES[5..6].include?(type)}
  required_attr :newStr,    if: -> {TYPES[5..6].include?(type)}
  required_attr :tElem,     if: -> {TYPES[3..4].include?(type)}
  required_attr :tAttr,     if: -> {TYPES[1..4].include?(type)}
  required_attr :value,     if: -> {TYPES[7..8].include?(type)}
  optional_attr :sep,       if: -> {TYPES[7..8].include?(type)}
end

