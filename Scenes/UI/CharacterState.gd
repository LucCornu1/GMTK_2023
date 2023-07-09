extends Control

class_name CharacterStateUI

enum CharacterClass
{
	GUERRIER,
	MAGE,
	VOLEUR,
	GNOME,
	ORC,
	SQUELETTE
}

@onready var label_node: Label = get_node("Label")
@onready var progress_bar_node: ProgressBar = get_node("ProgressBar")

func _ready():
	pass


func init(character: Character):
	if character == null:
		return
	
	match character._get_classname() :
		"GUERRIER" :
			label_node.set_text("Warrior")
		"VOLEUR" :
			label_node.set_text("Thief")
		"MAGE" :
			label_node.set_text("Mage")
		
	var __ = character.connect("health_loss", _update_health)

func _update_health(value: float):
	print(value)
	progress_bar_node.value = value

func _update_state(value: int):
	pass
