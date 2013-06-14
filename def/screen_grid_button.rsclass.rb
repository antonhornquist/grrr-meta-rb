is_subclass_of :user_view
belongs_to_module :grrr, :sc_abbreviation => "GR"

has_readable_attribute :value, :initial_value => false
has_attribute :lit, :initial_value => false
has_attribute :pressed, :initial_value => false
has_accessable_attribute :pressed_color
has_accessable_attribute :released_color, :only_in_sc => true
has_accessable_attribute :lit_color
has_accessable_attribute :unlit_color
has_accessable_attribute :action, :only_in_rb => true
has_sc_attribute :ns_shift_key_mask, :initial_value => 131072
has_sc_attribute :ns_alpha_shift_key_mask, :initial_value => 65536

has_rb_method :initialize
has_rb_class_method :fill_stroke, :arguments => [:g, :x, :y, :width, :height, :pen_width, :color]
has_rb_method :paint, :argument => :g

has_sc_class_method :view_class
has_sc_method :init, :arguments => [:parent, :bounds], :prefix_sc_arguments_with_arg => true
has_sc_method :draw

has_predicate :is_lit
has_setter :lit, :argument => :bool
has_predicate :is_pressed
has_setter :pressed, :argument => :bool
has_setter :value_action, :argument => :bool
has_setter :value, :argument => :bool
has_method :toggle_action

has_sc_method :mouse_down, :arguments => [:x, :y, :modifiers, :button_number, :click_count]
has_sc_method :mouse_up, :arguments => [:x, :y, :modifiers, :button_number, :click_count]
has_sc_method :check_hold_modifier, :argument => :modifiers
has_sc_method :shift_modifier, :argument => :modifiers
has_sc_method :caps_modifier, :argument => :modifiers

has_rb_method :do_action
