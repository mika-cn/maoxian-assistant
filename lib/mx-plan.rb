require_relative 'json-object'
require_relative 'mx-plan/mx-action'

class MxPlan
  include JsonObject

  required_attr :name
  required_attr :pattern
  optional_attr :excludePattern
  required_attr :version
  optional_attr :disabled
  optional_attr :actions, collection: true, klass: ::MxAction
  optional_attr :tags
  optional_attr :contributors
  optional_attr :comment, to_hash: false
end
