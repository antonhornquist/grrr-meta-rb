belongs_to_module :grrr, :sc_abbreviation => "GR"
is_subclass_of :abstract_toggle

has_accessable_attribute :toggle_pressed_action, :initial_value => nil
has_accessable_attribute :toggle_released_action, :initial_value => nil
has_accessable_attribute :toggle_value_pressed_action, :initial_value => nil
has_accessable_attribute :toggle_range_pressed_action, :initial_value => nil
has_attribute :filled
has_attribute :saved_range, :initial_value => nil

initializes_with :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}, {:nillable=>false}, {:orientation=>:vertical}]

has_sc_init_method :arguments => [:parent, :origin], :prefix_sc_arguments_with_arg => true

has_class_method :new_decoupled, :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:nillable=>false}, {:orientation=>:vertical}]

has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}, {:nillable=>false}, {:orientation=>:vertical}]

has_class_method :new_nillable, :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}, {:orientation=>:vertical}]

has_predicate :is_filled
has_setter :filled
has_setter :nillable
has_method :validate_value, :argument => :value, :prefix_sc_arguments_with_arg => true
has_method :flash, :argument => {:delay=>nil}
has_method :flash_toggle_value, :arguments => [:value, {:delay=>nil}]
has_predicate :pr_view_button_state_change_affected_values_pressed
