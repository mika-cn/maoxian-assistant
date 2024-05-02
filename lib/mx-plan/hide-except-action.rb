require_relative '../json-object'

class HideExceptAction
  include JsonObject

=begin
  Example:
  {
    ...
    actions: [
      {
        hideExcept: {
          "inside": ".post",
          "except": [".post-title", ".post-content"]
        }
      }
    ]
  }
=end

  required_attr :inside
  required_attr :except
end
