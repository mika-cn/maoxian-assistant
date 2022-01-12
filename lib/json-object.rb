module JsonObject

  def self.included(klass)
    klass.extend ClassMethods
    klass.include ConditionFns
  end

  module ClassMethods
    DEFAULT_OPTIONS = {to_hash: true, collection: false}

    def required_attr(name, options = {})
      @attr_defines ||= {}
      @attr_defines[name.to_s] = DEFAULT_OPTIONS.merge(options).merge({required: true})
      self.attr_reader name
    end

    def optional_attr(name, options = {})
      @attr_defines ||= {}
      @attr_defines[name.to_s] = DEFAULT_OPTIONS.merge(options).merge({required: false})
      self.attr_reader name
    end
  end

  module ConditionFns
    def value_in(name, *values)
      values.any? { |value| value == self.send(name.to_sym) }
    end
  end


  class Collection
    include Enumerable
    attr_reader :klass, :members

    def initialize(klass, members)
      @members = (members || []).map {|it| klass.new(it) }
    end

    def each(&blk)
      members.each(&blk)
    end

    def valid?
      @errors = []
      each do |it|
        unless it.valid?
          @errors << it.errors
        end
      end
      @errors.size == 0
    end

    def errors
      @errors
    end

    def to_hash
      members.map(&:to_hash)
    end
  end

  def initialize(params)
    attr_defines.each_pair do |attr, attr_define|
      if params.has_key?(attr)
        if attr_define[:collection]
          instance_variable_set vname(attr), Collection.new(attr_define[:klass], params[attr])
        else
          instance_variable_set vname(attr), params[attr]
        end
      elsif attr_define[:default]
        instance_variable_set vname(attr), attr_define[:default]
      end
    end
  end

  def valid?
    @errors = []
    attr_defines.each_pair do |attr, attr_define|
      is_valid, error = validate_attr_define(attr, attr_define)
      @errors << error unless is_valid
    end
    return @errors.size == 0
  end

  def errors
    @errors
  end

  def validate_attr_define(attr, attr_define)
    validate_proc = -> {
      attr_value = instance_variable_get(vname(attr))
      if attr_define[:required] && attr_value.nil?
        return [false, "Required attribute: \"#{attr}\" is not provided"]
      end

      if attr_define[:in] && !attr_define[:in].include?(attr_value)
        return [false, "The value of #{attr} must be a member of\n [#{attr_define[:in].map(&:to_s).join(', ')}], \nbut it's value is #{attr_value}"]
      end

      if attr_define[:klass] && attr_value && !attr_value.valid?
        intent = " " * 4
        error = "#{attr}:\n" + attr_value.errors.map do |it|
          "#{intent}#{it}"
        end.join("\n")
        return [false, error]
      end

      return [true]
    }
    condition = attr_define[:if]
    if condition.is_a?(Proc)
      if self.instance_exec(&condition)
        return validate_proc.call
      else
        return [true]
      end
    else
      return validate_proc.call
    end
  end

  def to_hash
    hash = {}
    attr_defines.each_pair do |attr, attr_define|
      attr_value = instance_variable_get(vname(attr))
      if attr_define[:to_hash] && attr_value && (attr_define[:default].nil? || attr_define[:default] != attr_value)
        if attr_define[:collection]
          hash[attr] = attr_value.to_hash
        else
          hash[attr] = attr_value
        end
      end
    end
    hash
  end

  def attr_defines
    @_attr_defines ||= self.class.instance_variable_get("@attr_defines")
  end

  # get instance variable name
  def vname(k)
    return "@#{k}"
  end

end
