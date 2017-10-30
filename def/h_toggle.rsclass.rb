belongs_to_module :grrr, :sc_abbreviation => "GR"
is_subclass_of :toggle

has_readable_class_attribute :default_num_cols, :initial_value => 4, :render_as_rb_class_constant => true
has_readable_class_attribute :default_num_rows, :initial_value => 1, :render_as_rb_class_constant => true

initializes_with :arguments => [{:parent=>nil}, {:origin=>nil}, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}, {:nillable=>false}]

has_class_method :new_decoupled, :arguments => [{:parent=>nil}, {:origin=>nil}, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:nillable=>false}]

has_class_method :new_detached, :arguments => [{:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}, {:nillable=>false}]

has_class_method :new_nillable, :arguments => [{:parent=>nil}, {:origin=>nil}, {:num_cols=>nil}, {:num_rows=>nil}, {:enabled=>true}, {:coupled=>true}]
