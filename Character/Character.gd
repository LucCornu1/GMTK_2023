extends Node2D

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
var character_class : CharacterClass
var character_state : CharacterState
var character_action : CharacterAction

#Mutateurs
func SetClass(_class : CharacterClass):
	character_class = _class

func SetState(_state : CharacterState):
	character_state = _state

func SetAction(_action : CharacterAction):
	character_action = _action

#Assesseurs
func GetClass() -> CharacterClass:
	return character_class

func GetState() -> CharacterState:
	return character_state

func GetAction() -> CharacterAction:
	return character_action

func ChoseAction(_class : CharacterClass = character_class, _state : CharacterState = character_state) -> CharacterAction :
	return character_action
