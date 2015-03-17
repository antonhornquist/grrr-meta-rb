is_subclass_of :container_view
belongs_to_module :grrr, :sc_abbreviation => "GR"

has_accessable_attribute :toggle_pressed_action, :initial_value => nil
has_accessable_attribute :toggle_released_action
has_accessable_attribute :toggle_value_pressed_action, :initial_value => nil
has_accessable_attribute :toggle_range_pressed_action
has_accessable_attribute :toggle_value_changed_action, :initial_value => nil
has_readable_attribute :num_toggles
has_readable_attribute :orientation
has_readable_attribute :thumb_width, :initial_value => nil
has_readable_attribute :thumb_height, :initial_value => nil
has_attribute :coupled
has_attribute :nillable
has_attribute :filled
has_attribute :values_are_inverted, :initial_value => nil
has_attribute :toggles

initializes_with :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:orientation=>:vertical}, {:enabled=>true}, {:coupled=>true}, {:nillable=>false}] # TODO: orientation to be moved later in argument list

has_sc_init_method :arguments => [:parent, :origin, :orientation, :coupled, :nillable], :prefix_sc_arguments_with_arg => true

has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}, {:orientation=>:vertical}, {:enabled=>true}, {:coupled=>true}, {:nillable=>false}]

has_class_method :new_disabled, :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:orientation=>:vertical}, {:coupled=>true}, {:nillable=>false}]

has_class_method :new_decoupled, :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:orientation=>:vertical}, {:enabled=>true}, {:nillable=>false}]

has_setter :orientation

has_predicate :is_coupled
has_setter :coupled

has_predicate :is_nillable
has_setter :nillable

has_predicate :is_filled
has_setter :filled

has_predicate :values_are_inverted
has_setter :values_are_inverted

has_method :thumb_size
has_setter :thumb_width
has_setter :thumb_height
has_setter :thumb_size

has_method :value
has_setter :value, :argument => :val # TODO: change to value
has_setter :value_action, :argument => :val # TODO: change to value
has_method :validate_value, :argument => :val # TODO: change to value

has_method :maximum_toggle_value
has_method :toggle_value, :argument => :i
has_method :flash_toggle, :arguments => [:i, :delay]
has_method :set_toggle_value, :arguments => [:i, :val] # TODO: change to value
has_method :set_toggle_value_action, :arguments => [:i, :val] # TODO: change to value

has_setter :num_toggles
has_method :validate_num_toggles, :argument => :num_toggles, :prefix_sc_arguments_with_arg => true
has_predicate :is_valid_num_toggles, :argument => :num_toggles, :prefix_sc_arguments_with_arg => true

has_method :toggle_width
has_method :toggle_height

has_method :pr_reconstruct_children
has_method :pr_add_actions, :arguments => [:toggle, :index]
has_method :pr_set_num_toggles_defaults
