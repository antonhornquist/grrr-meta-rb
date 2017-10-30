is_subclass_of :multi_button_view
belongs_to_module :grrr, :sc_abbreviation => "GR"

has_accessable_attribute :step_pressed_action, :initial_value => nil
has_accessable_attribute :step_released_action, :initial_value => nil
has_accessable_attribute :step_value_changed_action, :initial_value => nil
has_readable_attribute :playhead
has_attribute :step_view_is_coupled
has_attribute :steps

initializes_with :arguments => [{:parent=>nil}, {:origin=>nil}, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}]

has_sc_init_method :arguments => [:coupled], :prefix_sc_arguments_with_arg => true

has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}]

has_class_method :new_decoupled, :arguments => [{:parent=>nil}, {:origin=>nil}, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}]

has_predicate :is_coupled
has_setter :coupled

has_predicate :step_is_pressed, :argument => :index
has_predicate :step_is_released, :argument => :index

has_method :value
has_setter :value, :argument => :val
has_setter :value_action, :argument => :val
has_method :validate_value, :argument => :val

has_method :step_value, :argument => :index
has_method :flash_step, :arguments => [:index, :delay]
has_method :set_step_value, :arguments => [:index, :val]
has_method :set_step_value_action, :arguments => [:index, :val]

has_method :num_steps

has_method :refresh_step, :argument => :index
has_method :refresh_steps

has_method :clear
has_method :clear_action
has_method :fill
has_method :fill_action

has_setter :playhead, :argument => :index

has_method :pr_xy_to_step_index, :arguments => [:x, :y]
has_method :pr_step_index_to_xy, :argument => :index
has_method :pr_button_value_by_step_index, :argument => :index
has_method :pr_set_button_value_by_step_index, :arguments => [:index, :val]
