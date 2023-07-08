extends Node2D

class_name Character

enum CharacterClass
{
	GUERRIER,
	MAGE,
	VOLEUR,
	PRETRE,
	ARTIFICIER,
	GOBELIN,
	ORC,
	SQUELETTE
}
enum CharacterState
{
	NEUTRE,
	COLERE,
	PEUR,
	CONFIANCE,
	ENNUI
}
enum CharacterAction
{
	ACTION1,
	ACTION2,
	ACTION3,
	ATTENDRE
}
var character_class
var character_state
var character_action

func _ready():
	pass

func _process(_delta: float):
	pass

func _physics_process(_delta: float):
	pass

func do_action():
	pass
