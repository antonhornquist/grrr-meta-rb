is_subclass_of :abstract_toggle
belongs_to_module :grrr, :sc_abbreviation => "GR"

initializes_with :arguments => [:parent, :origin, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}, {:nillable=>false}]

has_method :lo
has_setter :lo
has_setter :active_lo, :argument => :lo

has_method :hi
has_setter :hi
has_setter :active_hi, :argument => :hi

has_method :range
has_setter :range
has_setter :active_range, :argument => :range

has_method :set_span, :arguments => [:lo, :hi]
has_method :set_span_active, :arguments => [:lo, :hi]

has_predicate :value_within_range, :argument => :val

has_method :flash_range, :argument => {:ms => nil}
has_method :flash_lo, :argument => {:ms => nil}
has_method :flash_hi, :argument => {:ms => nil}

has_method :validate_value, :argument => :val
