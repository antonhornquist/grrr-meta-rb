is_subclass_of :abstract_monome
belongs_to_module :grrr, :sc_abbreviation => "GR"
initializes_with :arguments => [:name, {:view=>nil}, {:origin=>nil}, {:create_top_view_if_none_is_supplied=>true}]
