require_relative 'json-object'
require_relative 'mx-plan-action'

class MxPlan
  include JsonObject

  required_attr :name
  required_attr :pattern
  required_attr :pick, if: -> {frame == 'top'}
  optional_attr :hide
  optional_attr :show
  optional_attr :chAttr, collection: true, klass: ::MxPlanAction
  optional_attr :tags
  optional_attr :comment, to_hash: false
  optional_attr :frame, in: ['top', 'child'], default: 'top'
end
