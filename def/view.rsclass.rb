belongs_to_module :grrr, :sc_abbreviation => "GR"

has_readable_class_attribute :default_num_cols, :initial_value => 4, :render_as_rb_class_constant => true
has_readable_class_attribute :default_num_rows, :initial_value => 4, :render_as_rb_class_constant => true
has_readable_class_attribute :default_indicate_repeat, :initial_value => 2, :render_as_rb_class_constant => true
has_readable_class_attribute :default_indicate_interval, :initial_value => 50, :render_as_rb_class_constant => true
has_readable_class_attribute :default_flash_delay, :initial_value => 25, :render_as_rb_class_constant => true

has_readable_attribute :parent
has_readable_attribute :origin
has_readable_attribute :num_cols
has_readable_attribute :num_rows
has_accessable_attribute :id
has_readable_attribute :view_led_refreshed_action
has_accessable_attribute :action
has_attribute :is_lit_at_func
has_attribute :value
has_attribute :points_pressed
has_attribute :inverted_leds_map
has_attribute :parent_view_led_refreshed_listener
has_attribute :enabled
has_attribute :view_button_state_changed_action
has_attribute :view_was_enabled_action
has_attribute :view_was_disabled_action

initializes_with :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}], :sc_init_instance_method_with_same_arguments_as_new => true

has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}]
has_class_method :new_disabled, :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}]

comment "Bounds"

has_method :num_view_buttons, :rb_method_body => %q{
@num_cols * @num_rows
}, :sc_method_body => %q{
^numCols * numRows
}
has_cast_method :points
has_cast_method :points_from_origin
has_cast_method :points_from, :arguments => [:origin], :prefix_sc_arguments_with_arg => true
has_class_method :bounds_to_points, :arguments => [:origin, :num_cols, :num_rows]
has_class_method :points_sect, :arguments => [:points1, :points2], :prefix_sc_arguments_with_arg => true
has_class_predicate :bounds_contain_point, :arguments => [:origin, :num_cols, :num_rows, :point]
has_method :left_top_point
has_method :right_top_point
has_method :left_bottom_point
has_method :right_bottom_point

has_method :leftmost_col # TODO
has_method :rightmost_col # TODO
has_method :topmost_row # TODO
has_method :bottommost_row # TODO

comment "Validations"

has_method :validate_contains_point, :arguments => [:point]
has_predicate :contains_point, :arguments => [:point]
has_method :validate_contains_bounds, :arguments => [:origin, :num_cols, :num_rows], :prefix_sc_arguments_with_arg => true
has_predicate :contains_bounds, :arguments => [:origin, :num_cols, :num_rows], :prefix_sc_arguments_with_arg => true

comment "Button Events and State"

has_method :press, :arguments => [:point]
has_method :release, :arguments => [:point]
has_method :release_all
has_method :release_all_within_bounds, :arguments => [:origin, :num_cols, :num_rows], :prefix_sc_arguments_with_arg => true
has_predicate :is_pressed_at, :arguments => [:point]
has_predicate :is_released_at, :arguments => [:point]
has_predicate :is_pressed_at_skip_validation, :arguments => [:point]
has_predicate :any_pressed
has_predicate :any_pressed_within_bounds, :arguments => [:origin, :num_cols, :num_rows], :prefix_sc_arguments_with_arg => true
has_predicate :any_released
has_predicate :any_released_within_bounds, :arguments => [:origin, :num_cols, :num_rows], :prefix_sc_arguments_with_arg => true
has_predicate :all_pressed
has_predicate :all_pressed_within_bounds, :arguments => [:origin, :num_cols, :num_rows], :prefix_sc_arguments_with_arg => true
has_predicate :all_released
has_predicate :all_released_within_bounds, :arguments => [:origin, :num_cols, :num_rows], :prefix_sc_arguments_with_arg => true
has_method :num_pressed
has_method :num_pressed_within_bounds, :arguments => [:origin, :num_cols, :num_rows], :prefix_sc_arguments_with_arg => true
has_method :num_released
has_method :num_released_within_bounds, :arguments => [:origin, :num_cols, :num_rows], :prefix_sc_arguments_with_arg => true
has_method :first_pressed
has_method :last_pressed
has_method :leftmost_col_pressed
has_method :rightmost_col_pressed
has_method :topmost_row_pressed
has_method :bottommost_row_pressed
has_method :leftmost_pressed
has_method :rightmost_pressed
has_method :topmost_pressed
has_method :bottommost_pressed
has_method :handle_view_button_event, :arguments => [:source, :point, :pressed]
has_method :points_pressed
has_method :points_pressed_within_bounds, :arguments => [:origin, :num_cols, :num_rows], :prefix_sc_arguments_with_arg => true

comment "Leds and Refresh"

has_method :refresh, :argument => {:refresh_children=>true}
has_method :refresh_bounds, :arguments => [:origin, :num_cols, :num_rows, {:refresh_children=>true}], :prefix_sc_arguments_with_arg => true
has_method :refresh_points, :arguments => [:points, {:refresh_children=>true}]
has_method :refresh_point, :arguments => [:point, {:refresh_children=>true}]
has_predicate :is_lit_at, :argument => :point
has_predicate :is_unlit_at, :argument => :point
has_predicate :any_lit
has_predicate :all_lit
has_predicate :any_unlit
has_predicate :all_unlit

comment "Indicate support"

comment <<EOC
	DOC:
	Indicate schedules to set leds of a specific area or of a collection of points to first lit and the unlit. This process is repeated a specified number of times (repeat) and with a specified delay in milliseconds (interval). When done it refreshes the points. Leds will be affected even though they are covered by child views. This is mainly used to indicate added / detached views and attached / detached controllers.
EOC

has_method :indicate_view, :arguments => [{:repeat=>nil}, {:interval=>nil}]
has_method :indicate_bounds, :arguments => [:origin, :num_cols, :num_rows, {:repeat=>nil}, {:interval=>nil}], :prefix_sc_arguments_with_arg => true
has_method :indicate_point, :arguments => [:point, {:repeat=>nil}, {:interval=>nil}]
has_method :indicate_points, :arguments => [:points, {:repeat=>nil}, {:interval=>nil}]

comment "Flash support"

has_method :flash_view, :arguments => [{:delay=>nil}]
has_method :flash_bounds, :arguments => [:origin, :num_cols, :num_rows, {:delay=>nil}], :prefix_sc_arguments_with_arg => true
has_method :flash_point, :arguments => [:point, {:delay=>nil}]
has_method :flash_points, :arguments => [:points, {:delay=>nil}]

comment "Enable / Disable View"

has_method :enable
has_method :disable
has_predicate :is_enabled
has_predicate :is_disabled
has_setter :enabled, :argument => :bool

comment "Action and Value"

has_method :add_action, :arguments => [:function, {:selector=>:action}]
has_method :remove_action, :arguments => [:function, {:selector=>:action}]

comment <<EOC
	DOC:
	Returns the current state. This will not evaluate the function assigned to action. 
EOC

has_method :value

comment <<EOC
	DOC:
	Sets the view to display the state of a new value. This will not evaluate the function assigned to action.
EOC

has_setter :value

comment <<EOC
	DOC:
	Sets the view to display the state of a new value, and evaluates action, if the value has changed. 
EOC

has_setter :value_action, :argument => :value, :prefix_sc_arguments_with_arg => true
has_method :do_action
has_method :validate_value, :arguments => [:value], :prefix_sc_arguments_with_arg => true

comment "Parent - Child"

has_method :validate_parent_origin_and_add_to_parent, :arguments => [:parent, :origin], :prefix_sc_arguments_with_arg => true
has_method :remove
has_predicate :has_parent
has_predicate :is_detached
has_predicate :has_view_led_refreshed_action
has_method :set_parent_reference, :arguments => [:parent, :origin], :prefix_sc_arguments_with_arg => true
has_method :remove_parent_reference
has_method :get_parents

comment "String representation"

has_cast_method :string, :only_in_sc => true
has_cast_method :s, :only_in_rb => true

has_method :plot
has_method :plot_tree
has_method :post_tree, :arguments => [{:include_details=>false}, {:indent_level=>0}]
has_cast_method :plot, :arguments => [{:indent_level=>0}]
has_cast_method :tree, :arguments => [{:include_details=>false}, {:indent_level=>0}]
