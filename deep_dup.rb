# REV: I wouldn't put it in a separate file,
# however, it's all about personal preference and
# still looks fine to me

class Array
  def deep_dup
    [].tap do |new_array|
      self.each do |el|
        new_array << (el.is_a?(Array) ? el.deep_dup : el)
      end
    end
  end
end