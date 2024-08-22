require_relative '../../json-object'

module Action
  class HideExcept
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
end
