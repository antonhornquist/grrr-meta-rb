is_subclass_of :container_view
belongs_to_module :grrr, :sc_abbreviation => "GR"

has_accessable_attribute :button_pressed_action, :initial_value => nil
has_accessable_attribute :button_released_action
has_accessable_attribute :button_value_changed_action, :initial_value => nil
has_readable_attribute :button_array_size
has_readable_attribute :behavior
has_attribute :coupled
has_attribute :buttons

initializes_with :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}, {:behavior=>:toggle}]

has_sc_init_method :arguments => [:parent, :origin, :coupled, :behavior], :prefix_sc_arguments_with_arg => true

has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}, {:behavior=>:toggle}]

has_class_method :new_disabled, :arguments => [{:parent=>nil}, {:origin=>nil}, {:num_cols=>nil}, {:num_rows=>nil}, {:coupled=>true}, {:behavior=>:toggle}]

has_class_method :new_decoupled, :arguments => [{:parent=>nil}, {:origin=>nil}, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:behavior=>:toggle}]

has_predicate :is_coupled
has_setter :coupled

has_setter :behavior

has_predicate :button_is_pressed, :arguments => [:x, :y]
has_predicate :button_is_released, :arguments => [:x, :y]

has_method :clear
has_method :clear_action
has_method :fill
has_method :fill_action

has_method :value
has_setter :value, :argument => :val # TODO: rename to value
has_setter :value_action, :argument => :val # TODO: rename to value
has_method :validate_value, :argument => :val # TODO: rename to value

has_method :button_value, :arguments => [:x, :y]
has_method :flash_button, :arguments => [:x, :y, :delay]
has_method :set_button_value, :arguments => [:x, :y, :val] # TODO: rename to value
has_method :set_button_value_action, :arguments => [:x, :y, :val] # TODO: rename to value

has_setter :button_array_size
has_method :validate_button_array_size, :argument => :button_array_size, :prefix_sc_arguments_with_arg => true

has_method :num_button_cols
has_method :num_button_rows
has_method :num_buttons
has_method :button_width
has_method :button_height

has_method :pr_reconstruct_children
has_method :pr_add_actions, :arguments => [:button, :x, :y]
