require 'treetop'

# Load our custom syntax node classes so the parser can use them
require File.join(File.dirname(__FILE__), 'node_extensions.rb')

module Purolie
  class Parser

    # Load the grammar file
    grammar_file = File.join(File.dirname(__FILE__), 'grammar/puppetclass_parser.treetop')
    puts ">> Grammar used for parsing : #{grammar_file}"

    Treetop.load(grammar_file)
    @@parser = PuppetClassParser.new

    def parse(data)
      tree = @@parser.parse(data)
      puts tree.inspect
      if (tree.nil?)
        puts ">> ERRROR <<"
        puts @@parser
        @@parser.failure_reason =~ /^(Expected .+) after/m
        puts "#{$1.gsub("\n", '$NEWLINE')}:"
        puts data.lines.to_a[@@parser.failure_line - 1]
        puts "#{'~' * (@@parser.failure_column - 1)}^"

        raise Exception, "Parse error at offset: #{@@parser.index}"
      end

      return tree.to_object
    end

  end
end
