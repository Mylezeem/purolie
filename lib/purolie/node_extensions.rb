module PuppetClass

  class Body < Treetop::Runtime::SyntaxNode
    def to_hash
      return self.text_value
    end
  end

  class Unknown3 < Treetop::Runtime::SyntaxNode
    def to_hash
      return self.text_value
    end
  end
  class Unknown1 < Treetop::Runtime::SyntaxNode
    def to_hash
      return self.text_value
    end
  end
  class Unknown2 < Treetop::Runtime::SyntaxNode
    def to_hash
      return self.text_value
    end
  end
  class String < Treetop::Runtime::SyntaxNode
    def to_hash
      return self.text_value
    end
  end

  #
  # Include Nodes
  #
  class IncludeDeclaration < Treetop::Runtime::SyntaxNode
    #def name
    def to_hash
      self.elements.each do |include_class|
        if include_class.is_a?(PuppetClass::IncludeClass)
          return include_class.name
        end
      end
    end
  end

  class IncludeClass < Treetop::Runtime::SyntaxNode
    def name
      return self.text_value.strip
    end
  end

  #
  # Inner Class
  #
  class InnerClassDeclaration < Treetop::Runtime::SyntaxNode
    def name
      return 'test'
    end
  end

  class InnerClass < Treetop::Runtime::SyntaxNode
    def name
      return 'test'
    end
  end

  class InnerClassParameter < Treetop::Runtime::SyntaxNode
    def name
      return 'test'
    end
  end

  class InnerClassParameters < Treetop::Runtime::SyntaxNode
    def name
      return 'test'
    end
  end

  #
  # Outer Class
  #
  class OuterClassParameter < Treetop::Runtime::SyntaxNode
    def name
      return 'test'
    end
  end

  class OuterClassParameters < Treetop::Runtime::SyntaxNode
    def name
      return 'test'
    end
  end



  #
  # Class Nodes
  #
  class ClassName < Treetop::Runtime::SyntaxNode
    def name
      return 'test'
    end
  end

  class ClassDefinition < Treetop::Runtime::SyntaxNode
    def to_hash
      return '>> test2'
    end
  end

  class ClassParameters < Treetop::Runtime::SyntaxNode
    def to_hash
      variable_association_hash = {}
      self.elements.each do |variable_association|
        variable_association_hash.merge!(variable_association.to_hash)
      end
      return variable_association_hash
    end
  end

  class Variable < Treetop::Runtime::SyntaxNode
  end

  class Parameter < Treetop::Runtime::SyntaxNode
  end

  class ClassBody < Treetop::Runtime::SyntaxNode
    def to_array
      self.elements.each do |class_content|
        if class_content.is_a?(PuppetClass::ClassContent)
          return class_content.to_array
        end
      end
    end
  end

  class ClassContent < Treetop::Runtime::SyntaxNode
    def to_array
      class_list   = Array.new

     self.elements[0].elements.each do |class_content_node|

        case class_content_node
        when PuppetClass::IncludeDeclaration
          class_list.push(class_content_node.name)
        end
      end
      return class_list
    end
  end

  class ClassDeclaration < Treetop::Runtime::SyntaxNode
    def to_hash
      class_name     = nil
      class_includes = Array.new
      variable_hash  = {}

      self.elements.each do |top_level|
        top_level_class = top_level.class

        case top_level
        when PuppetClass::ClassDefinition
          class_name = top_level.text_value.squeeze(' ').split[1] 
        #when PuppetClass::ClassParameters
        #  variable_hash = top_level.to_hash
        when PuppetClass::ClassBody
          class_includes = top_level.to_array
        end

        #if top_level.is_a?(PuppetClass::ClassDefinition)
        #  class_name = top_level.text_value.squeeze(' ').split[1] 
        #elsif top_level.is_a?(PuppetClass::ClassParameters)
        # variable_hash = top_level.to_hash
        #end

      end

      return {'class_name' => class_name, 'includes' => class_includes, 'parameters' => variable_hash}
    end
  end

  class VariableAssociation < Treetop::Runtime::SyntaxNode
    def to_hash
      key   = nil
      value = nil

      self.elements.each do |elem|
        if elem.is_a?(PuppetClass::Variable)
          key = elem.text_value[1..-1]
        elsif elem.is_a?(PuppetClass::Parameter)
          value = elem.text_value
        end
      end

      return {key => value}
    end
  end

end
