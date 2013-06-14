belongs_to_module :grrr, :sc_abbreviation => "GR"
is_subclass_of :controller

has_readable_class_attribute :default_num_cols, :initial_value => 8, :render_as_rb_class_constant => true
has_readable_class_attribute :default_num_rows, :initial_value => 8, :render_as_rb_class_constant => true
has_accessable_class_attribute :key_control_enabled_by_default, :initial_value => false, :render_as_rb_class_constant => true
has_class_attribute :button_size, :initial_value => 25, :render_as_rb_class_constant => true
has_class_attribute :margin, :initial_value => 10, :render_as_rb_class_constant => true
has_class_attribute :key_control_area_num_cols, :initial_value => 8, :render_as_rb_class_constant => true
has_class_attribute :key_control_area_num_rows, :initial_value => 4, :render_as_rb_class_constant => true
has_class_attribute :key_control_area_border_color, :initial_value => :black, :render_as_rb_class_constant => true
has_class_attribute :keymaps
has_class_attribute :keymap

has_readable_attribute :read_only
has_readable_attribute :key_control_enabled, :initial_value => false
has_attribute :window
has_attribute :buttons
has_attribute :key_control_area_origins
has_attribute :current_key_control_area, :initial_value => 0
has_attribute :show_current_key_control_area, :initial_value => false
has_attribute :modifier_caps_is_on, :initial_value => false
has_attribute :modifier_shift_is_pressed, :initial_value => false
has_attribute :modifier_ctrl_is_pressed, :initial_value => false
has_attribute :modifier_alt_is_pressed, :initial_value => false

initializes_with :arguments => [{:num_cols=>nil}, {:num_rows=>nil}, {:view=>nil}, {:origin=>nil}, {:create_top_view_if_none_is_supplied=>true}, {:read_only=>false}]

has_sc_init_method :argument => :read_only, :prefix_sc_arguments_with_arg => true

has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}]
has_class_method :new_view, :arguments => [:view, {:read_only=>false}]

has_sc_class_method :init_class

has_class_method :set_keymap, :argument => :keymap_name
has_rb_class_method :stroke_rect, :arguments => [:g, :x, :y, :width, :height, :pen_width, :color]

has_method :cleanup

has_method :info
has_method :handle_view_button_state_changed_event, :arguments => [:point, :pressed]
has_method :handle_view_led_refreshed_event, :arguments => [:point, :on]

has_method :front

has_method :always_on_top
has_setter :always_on_top

has_method :toggle_key_control
has_method :enable_key_control
has_method :disable_key_control

has_method :release_all_screen_grid_buttons_within_key_control_area_bounds_unless_hold_modifier, :argument => :index
has_method :release_all_screen_grid_buttons_within_bounds, :arguments => [:origin, :num_cols, :num_rows], :prefix_sc_arguments_with_arg => true
has_method :release_all_screen_grid_buttons_unless_hold_modifier
has_method :release_all_screen_grid_buttons
has_method :release_screen_grid_button, :arguments => [:x, :y]

has_method :handle_key_control_event, :arguments => [:keycode, :pressed]
has_method :handle_key_control_arrow_event, :arguments => [:direction, :pressed]
has_method :handle_key_control_keymap_event, :arguments => [:keymap_index, :pressed]

has_predicate :is_arrow_keycode, :argument => :keycode
has_method :arrow_keycode_to_direction, :argument => :keycode

has_method :next_key_control_area
has_method :lookup_screen_grid_button, :arguments => [:area_index, :keymap_index]

has_method :pr_create_window
has_method :pr_configure_keyboard_actions

has_method :hold_modifier

has_method :flash_key_control_area
has_method :show_key_control_area
has_method :hide_key_control_area
