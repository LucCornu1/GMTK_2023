extends Control

class_name CharacterStateUI

@onready var label_node: Label = get_node("Label")
@onready var progress_bar_node: ProgressBar = get_node("ProgressBar")

func _ready():
	pass


func init(character: Character):
	if character == null:
		return
	
	var __ = character.connect("health_loss", _update_health)

func _update_health(value: float):
	print(value)
	progress_bar_node.value = value

func _update_state(value: int):
	pass
