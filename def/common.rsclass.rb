belongs_to_module :grrr, :sc_abbreviation => "GR"

has_class_attribute :indicate_added_removed_attached_detached, :initial_value => false
has_class_attribute :trace_button_events, :initial_value => false
has_class_attribute :trace_led_events, :initial_value => false

has_class_method :validate_using_jruby, :arguments => [:point]
