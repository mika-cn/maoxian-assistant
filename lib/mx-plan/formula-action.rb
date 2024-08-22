require_relative '../json-object'

class FormulaAction
  include JsonObject

=begin
  Example:
  {
    ...
    actions: [
      {
        formula: {
          "pick": ".svg-formula",
          "attr": "data-formula"
        }
      }
    ]
  }
=end

  required_attr :pick
  required_attr :attr
  optional_attr :block
end
