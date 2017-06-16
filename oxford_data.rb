require 'oxford_dictionary'
require 'yaml'
require 'pry'
class OxfordApi

  attr_accessor :client

  def initialize
    keys = YAML.load_file('application.yml')
    @client = OxfordDictionary::Client.new(app_id: keys['ID'], app_key: keys['SECRET'])
  end

  def get_words
    entry = client.entry('vapid')
  puts (entry)
  end
end

word = OxfordApi.new
word.get_words
