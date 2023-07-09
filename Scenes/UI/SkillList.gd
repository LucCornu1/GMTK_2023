extends Control

class_name SkillList


@onready var label_node: Label = get_node("Button/Label")
@onready var label2_node: Label = get_node("Button2/Label")
@onready var label3_node: Label = get_node("Button3/Label")
var active_character: Character : set = _set_active_character

signal skip_turn
signal action_selected

func _set_active_character(new_character: Character):
	if new_character != active_character:
		active_character = new_character


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	pass

func update_skills():
	var skill1: String = ""
	var skill2: String = ""
	var skill3: String = ""
	
	if not active_character.isAI:
		skill1 = active_character._get_action1_name()
		skill2 = active_character._get_action2_name()
		skill3 = active_character._get_action3_name()
	
	label_node.set_text(skill1)
	label2_node.set_text(skill2)
	label3_node.set_text(skill3)


func _on_active_character_changed(character: Character):
	if character._get_health() <= 0:
		emit_signal("skip_turn")
	
	_set_active_character(character)
	update_skills()
	
	if not active_character.isAI:
		visible = true


func _on_button_pressed():
	if active_character != null and not active_character.isAI:
		emit_signal("action_selected", active_character.CharacterAction.ACTION1)
		visible = false

func _on_button_2_pressed():
	if active_character != null and not active_character.isAI:
		emit_signal("action_selected", active_character.CharacterAction.ACTION2)
		visible = false

func _on_button_3_pressed():
	if active_character != null and not active_character.isAI:
		emit_signal("action_selected", active_character.CharacterAction.ACTION3)
		visible = false
