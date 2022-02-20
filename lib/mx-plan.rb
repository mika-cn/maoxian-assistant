require_relative 'json-object'
require_relative 'mx-plan/ch-attr-action'

class MxPlan
  include JsonObject

  required_attr :name
  required_attr :pattern
  required_attr :version
  optional_attr :pick
  optional_attr :disabled
  optional_attr :hide
  optional_attr :hideSibling
  optional_attr :show
  optional_attr :chAttr, collection: true, klass: ::ChAttrAction
  optional_attr :form
  optional_attr :config
  optional_attr :tags
  optional_attr :comment, to_hash: false
  optional_attr :contributors
end
