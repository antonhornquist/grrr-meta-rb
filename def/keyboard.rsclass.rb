is_subclass_of :view
belongs_to_module :grrr, :sc_abbreviation => "GR"

has_class_attribute :min_midi_note_number, :initial_value => 0, :render_as_rb_class_constant => true
has_class_attribute :max_midi_note_number, :initial_value => 127, :render_as_rb_class_constant => true

has_accessable_attribute :note_pressed_on_view_action
has_accessable_attribute :note_released_on_view_action
has_accessable_attribute :note_pressed_action
has_accessable_attribute :note_released_action
has_accessable_attribute :not_shown_note_state_changed_action
has_attribute :coupled
has_accessable_attribute :behavior
has_readable_attribute :basenote
has_readable_attribute :indicate_keys
has_attribute :notes_pressed_on_view
has_attribute :midi_note_lookup

initializes_with :arguments => [:parent, :origin, {:num_cols=>7}, {:num_rows=>2}, {:enabled=>true}, {:basenote=>60}, {:coupled=>true}, {:behavior=>:momentary}]

has_sc_init_method :arguments => [:parent, :origin, :basenote, :coupled, :behavior], :prefix_sc_arguments_with_arg => true

has_class_method :new_detached, :arguments => [{:num_cols=>7}, {:num_rows=>2}, {:enabled=>true}, {:basenote=>60}, {:coupled=>true}, {:behavior=>:momentary}]

has_class_method :new_disabled, :arguments => [:parent, :origin, {:num_cols=>7}, {:num_rows=>2}, {:basenote=>60}, {:coupled=>true}, {:behavior=>:momentary}]

has_class_method :new_decoupled, :arguments => [:parent, :origin, {:num_cols=>7}, {:num_rows=>2}, {:enabled=>true}, {:basenote=>60}, {:behavior=>:momentary}]

has_predicate :is_coupled
has_setter :coupled
has_setter :basenote
has_setter :indicate_keys

has_method :get_note_at, :argument => :point
has_method :get_point_of_note, :argument => :note

has_predicate :note_is_pressed_on_view, :argument => :note
has_predicate :note_is_released_on_view, :argument => :note
has_predicate :note_is_pressed, :argument => :note
has_predicate :note_is_released, :argument => :note
has_predicate :note_is, :arguments => [:note, :pressed]

has_method :keyrange
has_method :min_note_shown
has_method :max_note_shown
has_predicate :note_is_shown, :argument => :note
has_method :notes_shown

has_predicate :is_black_key, :argument => :note

has_method :flash_note, :arguments => [:note, {:delay=>nil}]
has_method :flash_notes, :arguments => [:notes, {:delay=>nil}]
has_method :flash_left_edge, :argument => {:delay=>nil}
has_method :flash_right_edge, :argument => {:delay=>nil}
has_method :get_left_edge_points
has_method :get_right_edge_points

has_method :pr_recalculate_midi_note_lookup

has_method :toggle_note_action, :argument => :note
has_method :toggle_note, :argument => :note
has_method :set_note_pressed_action, :argument => :note
has_method :set_note_pressed, :argument => :note
has_method :set_note_released_action, :argument => :note
has_method :set_note_released, :argument => :note
has_method :set_note_action, :arguments => [:note, :pressed]
has_method :set_note, :arguments => [:note, :pressed]
has_method :pr_set_note, :arguments => [:note, :pressed, :trigger_actions]

has_method :handle_not_shown_note_state_change, :arguments => [:note, :pressed]

has_setter :value_action, :argument => :value, :prefix_sc_arguments_with_arg => true
has_method :validate_value, :argument => :value, :prefix_sc_arguments_with_arg => true

has_method :validate_midi_note, :argument => :note
has_predicate :is_allowed_midi_note_number, :argument => :note
has_method :midi_notes_interval
