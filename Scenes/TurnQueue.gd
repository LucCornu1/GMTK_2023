extends Node

class_name TurnQueue

var active_character_id: int = 0 : set = _set_active_character_id
@onready var active_character: Character = get_child(active_character_id) : set = _set_active_character, get = _get_active_character
var character_array = []
var array_length: int = 0
var current_turn_count: int = 0

signal active_character_changed()


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
		# emit_signal("")

func _get_active_character() -> Character:
	return active_character

func _ready():
	initialize() # Temporary, should be called by the parent instead
	
	var __ = connect("active_character_changed", _on_active_character_changed)

func initialize():
	character_array = get_children(false) # Return all external children
	array_length = character_array.size()
	
	play_turn()
	play_turn()

func play_turn():
	if active_character == null:
		return
	
	await active_character.begin_turn()
	await active_character.do_action(null)
	next_turn()

func next_turn():
	current_turn_count += 1 # current_turn_count++ does not work and thats a shame
	_set_active_character_id(active_character_id + 1) # Avoid edge cases
	print(active_character_id)
	print(active_character)
	move_child(active_character, array_length - 1)

func _on_active_character_changed(new_id: int):
	_set_active_character(character_array[new_id])
