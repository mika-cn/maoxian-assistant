require_relative 'ch-attr-action'

module ChAttr
  def self.new_instance(params)
    if params.has_key? "action"
      # new structure
      NewChAttr.new(params)
    else
      OldChAttr.new(params)
    end
  end
end
