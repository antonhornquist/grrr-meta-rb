# TODO: remove, obsolete and covered by screen_grid functionality
belongs_to_module :grrr, :sc_abbreviation => "GR"
is_subclass_of :screen_grid

initializes_with :arguments => [{:view=>nil}, {:origin=>nil}, {:num_cols=>4}]

has_sc_init_method

has_class_method :new_wide, :arguments => [{:view=>nil}, {:origin=>nil}]
has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}]

has_method :index_to_point, :argument => :index
has_predicate :is_wide
has_method :info

has_rb_method :kbd_layout_to_s
has_sc_method :kbd_layout_as_string
