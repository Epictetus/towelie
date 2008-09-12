require 'find'
require 'rubygems'
require 'parse_tree'
require 'ruby2ruby'

module Towelie
  def files(dir)
    accumulator = []
    Find.find(dir) do |filename|
      next if File.directory? filename || filename =~ /\.git/
      accumulator << filename
    end
    accumulator
  end
  def load(dir)
    @translations = {}
    files(dir).each do |filename|
      @translations[filename] = ParseTree.translate File.read(filename)
    end
  end
  def def_nodes
    # this might have to become recursive at some point. also: although it retrieves the nodes, they're
    # embedded in two layers of arrays. that shit is fucked up. gotta fix that too, later.
    (@translations.values.collect do |translation|
      (translation.collect do |node|
        node if node.is_a? Array and node[0] == :defn
      end).compact
    end).compact
  end
  def duplication?(dir)
    load dir
    def_nodes.uniq != def_nodes
    # here's what you do. kill this, and get the stuff from def_nodes to give you the right level of
    # arrays. when you have that, you can say something more or less like this:
    #
    # duplications = (def_nodes.collect do |def_n|
    #   def_nodes.duplicates? def_n
    # end).compact
    # 
    # it might also be worthwhile to write an auto-compacting collect
  end
  def duplicated(dir)
    # load dir
    # duplicates = (def_nodes.collect do |node|
    #   node if def_nodes.duplicates? node
    # end).compact
  end
end

# every method needs a dir. therefore we should have an object which takes a dir (and probably
# loads it) on init.
