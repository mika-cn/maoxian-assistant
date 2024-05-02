require 'json'

module MigrationConvertToActions
  class << self

    def migrate(plan_path, output_path)
      content = File.open(plan_path, 'r').read
      plans = JSON.parse(content)
      new_plans = plans.map {|it| migrate_plan(it)}

      File.open(output_path, 'w') do |file|
        file.write JSON.pretty_generate(new_plans)
      end
    end

    def migrate_plan(plan)
      if plan.has_key? "actions"
        # already the new version
        return plan
      end

      new_plan = plan.slice(
        "name",
        "pattern",
        "excludePattern",
        "version",
        "contributors",
        "disabled",
      )

      attrs = %W[hide hideSibling hideExcept show chAttr config form pick]

      actions = []

      attrs.each do |attr|
        next if !plan.has_key?(attr)

        value = plan[attr]

        case attr
        when 'chAttr'
          value.each do |it|
            action = {"chAttr" => it}
            actions << action
          end
          break
        when 'hideExcept'
          value.each do |it|
            action = {"hideExcept" => it}
            actions << action
          end
          break
        else
          action = [[attr, value]].to_h
          actions << action
        end
      end

      new_plan["actions"] = actions
      if plan.has_key? "tags"
        new_plan["tags"] = plan["tags"]
      end
      if plan.has_key? "comment"
        new_plan["comment"] = plan["comment"]
      end
      new_plan["version"] = (Time.now.strftime "%Y%m%d").to_i
      new_plan
    end

    def attrbute2action(name, value)
      return [[name, value]].to_h
    end

  end
end
