belongs_to_module :grrr, :sc_abbreviation => "GR"

has_accessable_class_attribute :default
has_accessable_class_attribute :init_action
has_readable_class_attribute :all

has_readable_attribute :num_cols
has_readable_attribute :num_rows
has_readable_attribute :view, :initial_value => nil
has_readable_attribute :origin
has_accessable_attribute :on_remove
has_attribute :is_removed
has_attribute :bottom_right
has_attribute :view_button_state_changed_listener
has_attribute :view_led_refreshed_listener

initializes_with :arguments => [{:num_cols=>nil}, {:num_rows=>nil}, {:view=>nil}, {:origin=>nil}, {:create_top_view_if_none_is_supplied=>true}]

has_sc_init_method :arguments => [:num_cols, :num_rows, :view, :origin, :create_top_view_if_none_is_supplied], :prefix_sc_arguments_with_arg => true

has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}]

has_method :remove
has_method :cleanup

comment "Validations"

has_method :validate_contains_point, :arguments => [:point]
has_predicate :contains_point, :arguments => [:point]
has_predicate :is_removed

comment "Bounds"

has_method :num_buttons
has_cast_method :points

comment "Attaching and detaching"

has_predicate :is_attached
has_predicate :is_detached

has_method :attach, :arguments => [:view, :origin], :prefix_sc_arguments_with_arg => true
has_method :pr_attach, :arguments => [:view, :origin], :prefix_sc_arguments_with_arg => true
has_method :detach

has_method :emit_press, :argument => :point
has_method :emit_release, :argument => :point
has_method :emit_button_event, :arguments => [:point, :pressed]

has_predicate :is_pressed_by_this_controller_at, :argument => :point
has_predicate :is_released_by_this_controller_at, :argument => :point
has_predicate :is_pressed_at, :argument => :point
has_predicate :is_released_at, :argument => :point
has_predicate :is_lit_at, :argument => :point

has_method :handle_view_button_state_changed_event, :arguments => [:point, :pressed]
has_method :handle_view_led_refreshed_event, :arguments => [:point, :on]
has_method :refresh

comment <<EOC
	DOC:
	Indicates on a view that a Controller is attached. Flashes the Controller's bounds.
EOC

has_method :indicate_controller, :arguments => [{:repeat=>nil}, {:interval=>nil}]
has_method :validate_controller_is_attached

comment "Convenience methods"

has_method :add_button_state_changed_action, :argument => :function
has_method :remove_button_state_changed_action, :argument => :function
has_method :add_led_refreshed_action, :argument => :function
has_method :remove_led_refreshed_action, :argument => :function

comment "Delegate to view"

has_method :add_child, :arguments => [:view, :origin], :prefix_sc_arguments_with_arg => true
has_method :remove_child, :argument => :view, :prefix_sc_arguments_with_arg => true
has_method :plot
has_method :plot_tree
has_method :post_tree, :arguments => [{:include_details=>false}]
