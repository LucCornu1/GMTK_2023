extends Node2D

class_name Character

enum CharacterClass
{
	GUERRIER,
	MAGE,
	VOLEUR,
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

var character_class : CharacterClass
var character_state : CharacterState
var character_action : CharacterAction


@export var max_health: float = 100.0
var current_health: float = max_health : set = _set_health, get = _get_health

signal health_loss

@export var isAI: bool = false
@onready var animation_player_node: AnimationPlayer = get_node("AnimationPlayer")

signal animation_over()

var GuerrierAction = [
	[0.5,0.25,0.25,0], #Neutre
	[0.7,0.3,0,0], #Colère
	[0.1,0,0.9,0], #Peur
	[0.2,0.7,0,0.1], #Confiance
	[0.2,0,0,0.8]] #Ennui

var MageAction = [
	[0.5,0.2,0.1,0.2], #Neutre
	[0.4,0,0.6,0], #Colère
	[0,0.8,0,0.2], #Peur
	[0.8,0,0.1,0.1], #Confiance
	[0.1,0.1,0,0.8]] #Ennui

var VoleurAction = [
	[0.6,0.2,0.2,0], #Neutre
	[0.8,0.2,0,0], #Colère
	[0,0.1,0.8,0.1], #Peur
	[0.4,0.6,0,0], #Confiance
	[0.2,0,0,0.8]] #Ennui


#Mutateurs
func SetClass(_class : CharacterClass):
	character_class = _class

func SetState(_state : CharacterState):
	character_state = _state

func SetAction(_action : CharacterAction):
	character_action = _action

func _set_health(value: float):
	if value != current_health:
		current_health = value
		emit_signal("health_loss", current_health)

#Assesseurs
func GetClass() -> CharacterClass:
	return character_class

func GetState() -> CharacterState:  
	return character_state

func GetAction() -> CharacterAction:
	return character_action

func _get_classname() -> String: # WIP
	return "Warrior"

func _get_health() -> float:
	return current_health

#Fonctions membres

#Retourne l'action choisie par la classe du personnage et la sauvegarde.
func ChoseAction(_class : CharacterClass = character_class, _state : CharacterState = character_state) -> CharacterAction :
	var _action : CharacterAction
	var _tabAction
	match _class:
		CharacterClass.GUERRIER :
			_tabAction = GuerrierAction
		CharacterClass.MAGE :
			_tabAction = MageAction
		CharacterClass.VOLEUR :
			_tabAction = VoleurAction
	var _fRand : float = randf()
	
	if (_fRand < _tabAction[0]) : 
		_action = CharacterAction.ACTION1
	elif (_fRand < (_tabAction[0]+_tabAction[1])) :
		_action = CharacterAction.ACTION2
	elif (_fRand < (_tabAction[0]+_tabAction[1]+_tabAction[2])) :
		_action = CharacterAction.ACTION3
	else :
		_action = CharacterAction.ATTENDRE
	
	if (_state == character_state && _class == character_class) : #Sauvegarde de l'action uniquement si les opérateurs n'ont pas été surchargés
		character_action = _action
	
	return character_action #Retourne l'action choisie par la classe du personnage et la sauvegarde.

func _ready():
	pass

func _process(_delta: float):
	pass

func _physics_process(_delta: float):
	pass


func begin_turn():
	pass

func do_action(action: Node):
	animation_player_node.play("AttackAnimation")
	_set_health(_get_health() - 50.0)
	await animation_over


func _on_animation_end():
	emit_signal("animation_over")
