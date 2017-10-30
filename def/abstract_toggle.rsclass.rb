is_subclass_of :view
belongs_to_module :grrr, :sc_abbreviation => "GR"

has_writeable_attribute :coupled
has_readable_attribute :orientation
has_readable_attribute :thumb_width
has_readable_attribute :thumb_height
has_attribute :nillable
has_attribute :values_are_inverted
has_attribute :values_pressed

initializes_with :arguments => [{:parent=>nil}, {:origin=>nil}, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}, {:nillable=>false}, {:orientation=>:vertical}]

has_sc_init_method :arguments => [:coupled, :nillable, :orientation], :prefix_sc_arguments_with_arg => true

has_predicate :is_coupled
has_predicate :is_nillable
has_predicate :values_are_inverted
has_setter :values_are_inverted
has_method :thumb_size
has_setter :thumb_width
has_setter :thumb_height
has_setter :thumb_size
has_predicate :is_pressed
has_predicate :is_released
has_predicate :value_is_pressed, :argument => :value
has_predicate :value_is_released, :argument => :value
has_predicate :no_value_pressed
has_predicate :any_value_pressed
has_method :first_value_pressed
has_method :last_value_pressed
has_method :min_value_pressed
has_method :max_value_pressed
has_method :num_values_pressed
has_method :maximum_value
has_method :num_values
has_method :num_values_x
has_method :num_values_y
has_method :value_at, :argument => :point

comment "Thumb size"

has_method :validate_thumb_size, :argument => :thumb_size, :prefix_sc_arguments_with_arg => true
has_method :validate_thumb_width, :argument => :thumb_width, :prefix_sc_arguments_with_arg => true
has_method :validate_thumb_height, :argument => :thumb_height, :prefix_sc_arguments_with_arg => true
has_predicate :is_valid_thumb_size, :argument => :thumb_size, :prefix_sc_arguments_with_arg => true
has_predicate :is_valid_thumb_width, :argument => :thumb_width, :prefix_sc_arguments_with_arg => true
has_predicate :is_valid_thumb_height, :argument => :thumb_height, :prefix_sc_arguments_with_arg => true
