require_relative 'json-object'
require_relative 'mx-plan-action'

class MxPlan
  include JsonObject

  required_attr :name
  required_attr :pattern
  optional_attr :pick
  optional_attr :disabled
  optional_attr :hide
  optional_attr :hideSibling
  optional_attr :show
  optional_attr :chAttr, collection: true, klass: ::MxPlanAction
  optional_attr :tags
  optional_attr :comment, to_hash: false
  optional_attr :contributors
end
