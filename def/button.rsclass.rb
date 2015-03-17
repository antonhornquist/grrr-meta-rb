belongs_to_module :grrr, :sc_abbreviation => "GR"
is_subclass_of :view

has_readable_class_attribute :default_num_cols, :initial_value => 1, :render_as_rb_class_constant => true
has_readable_class_attribute :default_num_rows, :initial_value => 1, :render_as_rb_class_constant => true
has_readable_class_attribute :default_flash_delay_when_lit, :initial_value => 25, :render_as_rb_class_constant => true
has_readable_class_attribute :default_flash_delay_when_unlit, :initial_value => 50, :render_as_rb_class_constant => true

has_accessable_attribute :button_pressed_action, :initial_value => nil
has_accessable_attribute :button_released_action, :initial_value => nil
has_accessable_attribute :behavior
has_writeable_attribute :coupled
has_attribute :button_was_pressed

initializes_with :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}, {:behavior=>:toggle}]

has_sc_init_method :arguments => [:coupled, :behavior], :prefix_sc_arguments_with_arg => true

has_class_method :new_decoupled, :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}]
has_class_method :new_momentary, :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}]

has_predicate :is_coupled
has_predicate :is_pressed
has_predicate :is_released
has_method :flash, :argument => {:delay=>nil}
has_method :toggle_value
