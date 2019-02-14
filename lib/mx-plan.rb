require_relative 'json-object'
require_relative 'mx-plan/ch-attr-action'
require_relative 'mx-plan/hide-except-action'

class MxPlan
  include JsonObject

  required_attr :name
  required_attr :pattern
  optional_attr :excludePattern
  required_attr :version
  optional_attr :pick
  optional_attr :disabled
  optional_attr :hide
  optional_attr :hideSibling
  optional_attr :hideExcept, collection: true, klass: ::HideExceptAction
  optional_attr :show
  optional_attr :chAttr, collection: true, klass: ::ChAttrAction
  optional_attr :form
  optional_attr :config
  optional_attr :tags
  optional_attr :contributors
  optional_attr :comment, to_hash: false
end
