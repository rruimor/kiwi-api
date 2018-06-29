class CoreHelper
  CAMELIZED_REGEXP = /^([a-z]+)([A-Z]{1}[a-z]+)*$/
  CAPITALIZED_WORDS_REGEXP = /([A-Z]{1}[a-z_]+)/

  def self.camelize_keys(hash)
    hash.each_with_object({}) do |(k,v), new_hash|
      new_hash[camelize(k.to_s).to_sym]=v
    end
  end

  def self.rubify_keys(hash)
    hash.each_with_object({}) do |(k,v), new_hash|
      new_hash[rubify(k.to_s).to_sym]=v
    end
  end

  def self.camelize(string)
    return string if CAMELIZED_REGEXP =~ string
    capitalized = string.split('_').map(&:capitalize).join('')
    capitalized[0].downcase + capitalized[1..-1]
  end

  def self.rubify(string)
    (string[0].capitalize + string[1..-1]).split(CAPITALIZED_WORDS_REGEXP).reject(&:empty?).map(&:downcase).join('_')
  end
end
