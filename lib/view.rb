class View
  def to_ruby(nodes)
    Ruby2Ruby.new.process(nodes) + "\n"
  end
  def render(options = {})
    ERB.new(File.read("#{File.dirname(__FILE__) + "/" + options[:template]}"), nil, ">").result(binding)
  end
end
