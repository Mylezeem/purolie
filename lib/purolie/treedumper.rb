# Base class for formatted textual dump of a "model"

require 'puppet'
require 'puppet/pops'
require 'puppet/face'
require 'puppet/version'
require 'puppet/interface'
require 'puppet/parser'
require 'puppet/face'

module Purolie
  class TreeDumper
    def initialize
      @@dump_visitor ||= Puppet::Pops::Visitor.new(nil,"dump",0,0)
    end 
    def dump(o)
      do_dump(o)
    end 
    def do_dump(o)
      @@dump_visitor.visit_this(self, o)
    end 
  end
end
