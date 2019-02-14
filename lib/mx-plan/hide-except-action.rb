require_relative '../json-object'

class HideExceptAction
  include JsonObject

=begin
  Example:
  {
    ...
    hideExcept: [
      {
        "inside": ".post",
        "except": [".post-title", ".post-content"]
      }
    ]
  }
=end
  required_attr :inside
  required_attr :except
end
