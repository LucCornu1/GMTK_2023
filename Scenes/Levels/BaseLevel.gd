extends Node2D

class_name BaseLevel

@onready var turn_manager: TurnQueue = get_node("TurnQueue")

func _ready():
	turn_manager.initialize()
	
	var __ = turn_manager.connect("ai_turn", _on_end_turn)

func _process(_delta: float):
	pass

func _physics_process(_delta: float):
	pass


func _unhandled_key_input(event):
	if event.is_pressed():
		turn_manager.play_turn()


func _on_end_turn():
	turn_manager.play_turn()
