is_subclass_of :controller
belongs_to_module :grrr, :sc_abbreviation => "GR"

has_readable_class_attribute :all

has_attribute :client
has_attribute :name

initializes_with :arguments => [:num_cols, :num_rows, {:view=>nil}, {:origin=>nil}, {:create_top_view_if_none_is_supplied=>true}]

has_class_method :init_class

has_sc_init_method :arguments => [:name], :prefix_sc_arguments_with_arg => true

has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}]

has_method :handle_view_led_refreshed_event, :arguments => [:point, :on]

has_method :spawn_gui

has_method :permanent
has_setter :permanent

has_method :grab_devices
has_method :grab_grid
has_method :as_serial_osc_client
