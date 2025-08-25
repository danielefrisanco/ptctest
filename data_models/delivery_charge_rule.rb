class DeliveryChargeRule
  def initialize(rules)
    # order by decreasing limit to find the rule easily
    @rules = rules.sort_by { |rule| -rule[:upper_limit] }
  end

  def find_charge(total)
    return 0 if total.nil?

    rule = @rules.find { |rule| total >= rule[:upper_limit] }
    rule ? rule[:cost] : 0
  end
end