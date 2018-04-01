class Factory
  def self.new(*args, &block)
    Class.new do
      attr_accessor(*args)

      define_method :initialize do |*instance_args|
        @instance_args = instance_args
        args.each_with_index do |arg, index|
          raise ArgumentError, "Argument #{arg} should be a constant" 
          unless arg.is_a? Symbol
          public_send(instance_args[index])
        end                
      end

      def [](key)
        instance_variable_get(instance_variables[key]) if key.is_a? Fixnum
        public_send(key.to_sym)
        end
      end

      def []=(key)
        instance_variable_set(instance_variables[key]) if key.is_a? Fixnum
        public_send(key.to_sym)        
      end

      clas_eval(&block) if block_given?
    end
  end
end
