class Script_from_maven
  def hello
    puts 'Hello World 3!'
    puts ENV['JAVA_HOME']
  end
end

s = Script_from_maven.new
s.hello
