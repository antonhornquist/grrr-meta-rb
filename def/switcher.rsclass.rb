is_subclass_of :container_view
belongs_to_module :grrr, :sc_abbreviation => "GR"

has_readable_attribute :current_view, :initial_value => nil

initializes_with :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:press_through=>false}] # TODO: copied from container_view just to initialize @current_view

has_method :add_child, :arguments => [:view, :origin]
has_method :remove_child, :argument => :view
has_method :validate_ok_to_enable_child, :argument => :child
has_method :validate_ok_to_disable_child, :argument => :child
has_method :validate_ok_to_enable_or_disable_children

has_method :switch_to_view, :argument => :view
has_method :switch_to, :argument => :id
has_method :value
has_setter :value, :argument => :index
