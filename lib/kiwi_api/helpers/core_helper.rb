class Hash
  def camelize_keys
    self.each_with_object({}) do |(k,v), new_hash|
      new_hash[k.to_s.camelize.to_sym]=v
    end
  end

  def rubify_keys
    self.each_with_object({}) do |(k,v), new_hash|
      new_hash[k.to_s.rubify.to_sym]=v
    end
  end
end

class String
  CAMELIZED_REGEXP = /^([a-z]+)([A-Z]{1}[a-z]+)*$/
  CAPITALIZED_WORDS_REGEXP = /([A-Z]{1}[a-z_]+)/

  def camelize
    return self if CAMELIZED_REGEXP =~ self
    capitalized = self.split('_').map(&:capitalize).join('')
    capitalized[0].downcase + capitalized[1..-1]
  end

  def rubify
    (self[0].capitalize + self[1..-1]).split(CAPITALIZED_WORDS_REGEXP).reject(&:empty?).map(&:downcase).join('_')
  end
end