belongs_to_module :grrr, :sc_abbreviation => "GR"
is_subclass_of :container_view

has_attribute :points_pressed_by_source

initializes_with :arguments => [{:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}]

has_sc_init_method

has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}]
has_class_method :new_disabled, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}]

comment "Parent - Child"

has_method :set_parent_reference, :arguments => [:parent, :origin], :prefix_sc_arguments_with_arg => true

comment "Button events and state"

has_predicate :is_pressed_by_source_at, :arguments => [:source, :point]
has_predicate :is_released_by_source_at, :arguments => [:source, :point]
has_predicate :is_pressed_by_one_source_at, :argument => :point
has_predicate :is_not_pressed_by_any_source_at, :argument => :point
has_method :press, :argument => :point
has_method :release, :argument => :point
has_method :handle_view_button_event, :arguments => [:source, :point, :pressed]
