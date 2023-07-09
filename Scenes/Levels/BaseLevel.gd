extends Node2D

class_name BaseLevel

@onready var turn_manager: TurnQueue = get_node("TurnQueue")
@onready var skill_list_node: SkillList = get_node_or_null("CombatUI/BottomRight2/Skills")

func _ready():
	var __ = turn_manager.ai_turn.connect(_on_end_turn)
	
	if skill_list_node != null:
		__ = turn_manager.active_character_changed.connect(skill_list_node._on_active_character_changed)
	
	turn_manager.initialize()

func _process(_delta: float):
	pass

func _physics_process(_delta: float):
	pass


func _unhandled_key_input(event):
	if event.is_pressed():
		turn_manager.play_turn()


func _on_end_turn():
	turn_manager.play_turn()

func _skip_turn():
	turn_manager.next_turn()
