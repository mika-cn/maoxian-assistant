require_relative '../json-object'
require_relative 'hide-except-action'
require_relative 'ch-attr'

class MxAction
  include JsonObject
  optional_attr :hide
  optional_attr :hideSibling
  optional_attr :hideExcept, klass: ::HideExceptAction
  optional_attr :show
  optional_attr :chAttr, module: ::ChAttr
  optional_attr :pick
  optional_attr :form
  optional_attr :config
  optional_attr :tag
end
