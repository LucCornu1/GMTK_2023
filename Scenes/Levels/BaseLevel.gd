extends Node2D

class_name BaseLevel

@onready var turn_manager: TurnQueue = get_node("TurnQueue")

func _ready():
	turn_manager.initialize()

func _process(_delta: float):
	pass

func _physics_process(_delta: float):
	pass


func _unhandled_key_input(event):
	if event.is_pressed():
		turn_manager.play_turn()
