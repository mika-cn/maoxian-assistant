require_relative '../json-object'
require_relative 'action/hide-except'
require_relative 'action/execute-user-script'
require_relative 'action/formula'
require_relative 'action/change-attribute'

class MxAction
  include JsonObject
  optional_attr :hide
  optional_attr :hideSibling
  optional_attr :hideExcept, klass: Action::HideExcept
  optional_attr :show
  optional_attr :chAttr, module: ::Action::ChangeAttribute
  optional_attr :exec,    klass: ::Action::ExecuteUserScript
  optional_attr :formula, klass: ::Action::Formula
  optional_attr :pick
  optional_attr :select
  optional_attr :confirm
  optional_attr :clip
  optional_attr :form
  optional_attr :config
  optional_attr :tag
end
