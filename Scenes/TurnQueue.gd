extends Node

class_name TurnQueue

var active_character_id: int = 0 : set = _set_active_character_id
@onready var active_character: Character : set = _set_active_character, get = _get_active_character
var character_array = []
var array_length: int = 0
var current_turn_count: int = 0

signal active_character_changed()
signal ai_turn()


func _set_active_character_id(new_id: int) -> void:
	if new_id >= array_length:
		new_id = 0 # Make sure the array does not go out of bound
	
	if new_id != active_character_id:
		active_character_id = new_id
		_set_active_character(character_array[new_id])
		# emit_signal("active_character_changed", active_character_id)

func _set_active_character(new_character: Character) -> void:
	if new_character != active_character:
		active_character = new_character
		emit_signal("active_character_changed", active_character)

func _get_active_character() -> Character:
	return active_character

func _ready():
	var __ = connect("active_character_changed", _on_active_character_changed)
	__ = connect("ai_turn", _on_ai_turn)

func initialize():
	character_array = get_children(false) # Return all external children
	array_length = character_array.size()
	
	for c in character_array:
		var __ = c.end_turn.connect(_on_end_turn)
	
	if array_length > 0:
		_set_active_character(character_array[active_character_id]);

func play_turn():
	if active_character == null:
		return
	
	if active_character.isAI:
		var action = active_character.begin_turn()
		active_character.do_action(action)
	else:
		active_character.begin_turn()
		active_character.do_action(character_array)

func next_turn():
	current_turn_count += 1 # current_turn_count++ does not work and thats a shame
	_set_active_character_id(active_character_id + 1) # Avoid edge cases
	
	if active_character.isAI == true:
		emit_signal("ai_turn")


func _on_active_character_changed(character: Character):
	pass

func _on_ai_turn():
	pass

func _on_end_turn():
	next_turn()

func _on_action_selected(action):
	if active_character == null:
		return
	
	active_character.begin_turn()
	active_character.do_action(character_array, action)
