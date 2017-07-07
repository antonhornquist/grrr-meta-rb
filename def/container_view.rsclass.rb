belongs_to_module :grrr, :sc_abbreviation => "GR"
is_subclass_of :view

has_readable_attribute :press_through
has_attribute :children
has_attribute :acts_as_view

initializes_with :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:press_through=>false}]

has_sc_init_method :arguments => [:parent, :origin, :press_through], :prefix_sc_arguments_with_arg => true

has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:press_through=>false}]
has_class_method :new_disabled, :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:press_through=>false}]

comment "Parent - Child"

has_method :validate_ok_to_add_child, :arguments => [:view, :origin]
has_method :add_child, :arguments => [:view, :origin]
has_method :pr_add_child_no_flash, :arguments => [:view, :origin]
has_method :pr_add_child, :arguments => [:view, :origin, {:prevent_flash=>false}]
has_method :remove_all_children
has_method :pr_remove_all_children, :argument => {:prevent_flash=>false}
has_method :remove_child, :argument => :view
has_method :pr_remove_child, :arguments => [:view, {:prevent_flash=>false}]
has_predicate :is_parent_of, :argument => :view
has_method :enabled_children
has_predicate :has_child_at, :argument => :point
has_method :get_children_at, :argument => :point
has_predicate :has_any_enabled_child_at, :argument => :point
has_method :get_topmost_enabled_child_at, :argument => :point
has_predicate :is_empty
has_method :bring_child_to_front, :argument => :view
has_method :send_child_to_back, :argument => :view
has_method :num_children
has_method :pr_get_child_index, :argument => :child, :prefix_sc_arguments_with_arg => true

comment "Validations"

has_method :validate_ok_to_enable_child, :argument => :child
has_method :validate_ok_to_disable_child, :argument => :child
has_method :validate_within_bounds, :arguments => [:view, :origin]
has_predicate :is_within_bounds, :arguments => [:view, :origin]
has_method :validate_does_not_overlap_with_enabled_children, :arguments => [:view, :origin]
has_predicate :any_enabled_children_within_bounds, :arguments => [:origin, :num_cols, :num_rows]
has_method :validate_parent_of, :argument => :child

comment "Button events and state"

has_method :release_all
has_method :handle_view_button_event, :arguments => [:source, :point, :pressed]

comment "Leds and refresh"

has_method :refresh_point, :arguments => [:point, {:refresh_children=>true}]
has_predicate :is_lit_at, :argument => :point

comment "String representation"

has_cast_method :plot, :arguments => [{:indent_level=>0}]
has_cast_method :tree, :arguments => [{:include_details=>false}, {:indent_level=>0}]
