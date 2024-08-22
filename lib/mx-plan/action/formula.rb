require_relative '../../json-object'

module Action
  class Formula
    include JsonObject
    required_attr :pick
    required_attr :attr
    optional_attr :block
  end
end
