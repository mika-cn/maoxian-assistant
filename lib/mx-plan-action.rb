require_relative 'json-object'

class MxPlanAction
  include JsonObject
  TYPES = %w(self.replace self.attr parent.attr self.add self.remove)

  required_attr :type, in: TYPES
  required_attr :pick
  required_attr :attr,   if: -> {!['self.add', 'self.remove'].include?(type)}
  required_attr :subStr, if: -> {type == 'self.replace'}
  required_attr :newStr, if: -> {type == 'self.replace'}
  required_attr :tAttr,  if: -> {['self.attr', 'parent.attr'].include?(type)}
  required_attr :value,  if: -> {['self.add', 'self.remove'].include?(type)}
  optional_attr :sep
end

