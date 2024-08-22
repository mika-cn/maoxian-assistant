require_relative '../../json-object'

module Action
  class ExecuteUserScript
    include JsonObject

    required_attr :script
    optional_attr :args
    optional_attr :when, in: %w[actived selecting idle]
    optional_attr :once, in: [true, false]
  end
end
