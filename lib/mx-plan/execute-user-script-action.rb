require_relative '../json-object'

class ExecuteUserScriptAction
  include JsonObject

=begin
  Example:
  {
    ...
    actions: [
      {
        exec: {
          "script": "loadLazyImg",
          "args": ["article"],
          "when": "selecting",
          "once": true
        }
      }
    ]
  }
=end

  required_attr :script
  optional_attr :args
  optional_attr :when, in: %w[actived selecting idle]
  optional_attr :once, in: [true, false]
end
