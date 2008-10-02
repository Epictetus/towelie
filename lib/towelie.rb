require 'find'
require 'erb'
require 'rubygems'
require 'parse_tree'
require 'ruby2ruby'

require "#{File.dirname(__FILE__) + "/"}array"

require "#{File.dirname(__FILE__) + "/"}code_base"
require "#{File.dirname(__FILE__) + "/"}node_analysis"
require "#{File.dirname(__FILE__) + "/"}model"
require "#{File.dirname(__FILE__) + "/"}view"
require "#{File.dirname(__FILE__) + "/"}text_view"
require "#{File.dirname(__FILE__) + "/"}erb_view"
require "#{File.dirname(__FILE__) + "/"}controller"


class Towelie
  def initialize(view_format)
    @model = Model.new
    template = case view_format
    when :text
      "text.erb"
    when :console
      "console.erb"
    end
    @view = View.new(template)
  end
  delegate_thru_model :parse, :duplication?, :method_definitions
  delegate_thru_view :duplicated, :unique, :homonyms, :diff
end

# most methods need a dir loaded. therefore we should have an object which takes a dir (and probably
# loads it) on init. also a new Ruby2Ruby might belong in the initializer, who knows.

# ironically, Towelie itself is very not-DRY. lots of "parse dir".

# one thing I've been doing consistently is parsing the dir and collecting the method definitions.
# further, everything here assumes that this has happened. therefore! I think I should write some
# code which *ensures* it always happens.
