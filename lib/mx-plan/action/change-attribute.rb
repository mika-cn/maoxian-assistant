require_relative 'ch-attr-defines'

module Action
  module ChangeAttribute
    def self.new_instance(params)
      if params.has_key? "action"
        # new structure
        NewChAttr.new(params)
      else
        OldChAttr.new(params)
      end
    end
  end
end
