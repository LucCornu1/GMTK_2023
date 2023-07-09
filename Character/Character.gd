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
enum Evenement
{
	AUCUN,
	ENNEMI_TUE
}
@export var character_class : CharacterClass
var character_state : CharacterState
var character_action : CharacterAction
var temps_changement_etat : int


@export var max_health: float = 100.0
var current_health: float = max_health : set = _set_health, get = _get_health

@export var max_mana: float = 100.0
var current_mana: float = max_mana : set = _set_mana, get = _get_mana

signal health_loss
signal end_turn

@export var isAI: bool = false
@onready var animation_player_node: AnimationPlayer = get_node("AnimationPlayer")

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
		
func _set_mana(value: float):
	if value != current_mana:
		current_mana = value
		emit_signal("mana_change", current_mana)

#Assesseurs
func GetClass() -> CharacterClass:
	return character_class

func GetState() -> CharacterState:
	return character_state

func GetAction() -> CharacterAction:
	return character_action

func _get_classname() -> String: 
	return CharacterClass.keys()[character_class]

func _get_health() -> float:
	return current_health
	
func _get_mana() -> float:
	return current_mana

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
		_ :
			_tabAction = GuerrierAction
	var _fRand : float = randf()
	
	match _state :
		CharacterState.NEUTRE :
			if (_fRand < _tabAction[0][0]) :
				_action = CharacterAction.ACTION1
			elif (_fRand < (_tabAction[0][0]+_tabAction[0][1])) :
				_action = CharacterAction.ACTION2
			elif (_fRand < (_tabAction[0][0]+_tabAction[0][1]+_tabAction[0][2])) :
				_action = CharacterAction.ACTION3
			else :
				_action = CharacterAction.ATTENDRE
		CharacterState.COLERE :
			if (_fRand < _tabAction[1][0]) :
				_action = CharacterAction.ACTION1
			elif (_fRand < (_tabAction[1][0]+_tabAction[1][1])) :
				_action = CharacterAction.ACTION2
			elif (_fRand < (_tabAction[1][0]+_tabAction[1][1]+_tabAction[1][2])) :
				_action = CharacterAction.ACTION3
			else :
				_action = CharacterAction.ATTENDRE
		CharacterState.PEUR :
			if (_fRand < _tabAction[2][0]) :
				_action = CharacterAction.ACTION1
			elif (_fRand < (_tabAction[2][0]+_tabAction[2][1])) :
				_action = CharacterAction.ACTION2
			elif (_fRand < (_tabAction[2][0]+_tabAction[2][1]+_tabAction[2][2])) :
				_action = CharacterAction.ACTION3
			else :
				_action = CharacterAction.ATTENDRE
		CharacterState.CONFIANCE :
			if (_fRand < _tabAction[3][0]) :
				_action = CharacterAction.ACTION1
			elif (_fRand < (_tabAction[3][0]+_tabAction[3][1])) :
				_action = CharacterAction.ACTION2
			elif (_fRand < (_tabAction[3][0]+_tabAction[3][1]+_tabAction[3][2])) :
				_action = CharacterAction.ACTION3
			else :
				_action = CharacterAction.ATTENDRE
		CharacterState.ENNUI :
			if (_fRand < _tabAction[4][0]) :
				_action = CharacterAction.ACTION1
			elif (_fRand < (_tabAction[4][0]+_tabAction[4][1])) :
				_action = CharacterAction.ACTION2
			elif (_fRand < (_tabAction[4][0]+_tabAction[4][1]+_tabAction[4][2])) :
				_action = CharacterAction.ACTION3
			else :
				_action = CharacterAction.ATTENDRE
		_ :
			if (_fRand < _tabAction[0][0]) :
				_action = CharacterAction.ACTION1
			elif (_fRand < (_tabAction[0][0]+_tabAction[0][1])) :
				_action = CharacterAction.ACTION2
			elif (_fRand < (_tabAction[0][0]+_tabAction[0][1]+_tabAction[0][2])) :
				_action = CharacterAction.ACTION3
			else :
				_action = CharacterAction.ATTENDRE
	if (_state == character_state && _class == character_class) : #Sauvegarde de l'action uniquement si les opérateurs n'ont pas été surchargés
		character_action = _action
	return character_action #Retourne l'action choisie par la classe du personnage et la sauvegarde.

func _ready():
	temps_changement_etat = 0

func _process(_delta: float):
	pass

func _physics_process(_delta: float):
	pass

func begin_turn():
	temps_changement_etat = temps_changement_etat + 1 # Augmente le temps depuis le dernier changement d'émotion

func do_action(action: Node):
	animation_player_node.play("AttackAnimation")
	_set_health(_get_health() - 50.0)

func _on_animation_end():
	emit_signal("end_turn")
	emit_signal("animation_over")

func CheckChangeState(_evenement : Evenement = Evenement.AUCUN, tab_pv_allie = [], tab_pvmax_allie=[]) :
	if (temps_changement_etat < 1) :
		return
	var _fRand : float = randf()
	if (_evenement != Evenement.AUCUN) :
		match character_class :
			CharacterClass.GUERRIER : # CAS DU GUERRIER
				if (current_health > max_health/2) : #PV>50%
					if (_fRand < 0.1) : #10%
						ChangeState(CharacterState.ENNUI)
						return
					elif (_fRand < 0.1 + 0.3) : #30%
						ChangeState(CharacterState.CONFIANCE)
						return
				elif (current_health < max_health/4) : #PV<25%
					if (_fRand < 0.2) : #20%
						ChangeState(CharacterState.COLERE)
						return
					elif (_fRand < 0.2 + 0.3) : #30%
						ChangeState(CharacterState.PEUR)
						return
				if (tab_pv_allie.size() == tab_pvmax_allie.size()) : #Seulement si les tableaux ont la même taille.
					for i in range (0, tab_pv_allie.size()) :
						_fRand = randf()
						if (tab_pv_allie[i] < (tab_pvmax_allie[i]/4) && _fRand < 0.2) : #Vérification de changement d'état par allié en dessous de 25%
							ChangeState(CharacterState.COLERE)
							return
				# Pas de vérification de la mana.
				match character_state :
					CharacterState.COLERE :
						pass
					CharacterState.PEUR :
						if (_fRand<0.1) : #10%
							ChangeState(CharacterState.NEUTRE)
							return
					CharacterState.CONFIANCE :
						if (_fRand<0.1) : #10%
							ChangeState(CharacterState.ENNUI)
							return
					CharacterState.ENNUI :
						pass
					_ :
						pass
			CharacterClass.MAGE : # CAS DU MAGE
				if (current_health > max_health/2) : #PV>50%
					pass
				elif (current_health < max_health/4) : #PV<25%
					if (_fRand < 0.3) : #30%
						ChangeState(CharacterState.PEUR)
						return
				if (tab_pv_allie.size() == tab_pvmax_allie.size()) : #Seulement si les tableaux ont la même taille.
					for i in range (0, tab_pv_allie.size()) :
						_fRand = randf()
						if (tab_pv_allie[i] < (tab_pvmax_allie[i]/4) && _fRand < 0.2) : #Vérification de changement d'état par allié en dessous de 25%
							ChangeState(CharacterState.PEUR)
							return
						elif (tab_pv_allie[i] < (tab_pvmax_allie[i]/4) && _fRand < 0.2+0.2) :
							ChangeState(CharacterState.COLERE)
							return
				if (current_mana < max_mana/4) : #Mana<25%
					if (_fRand < 0.3) : #30%
						ChangeState(CharacterState.ENNUI)
						return
				elif (current_mana > max_mana/2) : #MANA>50%
					if (_fRand < 0.2) : #20%
						ChangeState(CharacterState.CONFIANCE)
						return
				match character_state :
					CharacterState.COLERE :
						if (_fRand<0.1) : #10%
							ChangeState(CharacterState.NEUTRE)
					CharacterState.PEUR :
						pass
					CharacterState.CONFIANCE :
						if (_fRand<0.1) : #10%
							ChangeState(CharacterState.ENNUI)
					CharacterState.ENNUI :
						pass
					_ :
						pass
				pass
			CharacterClass.VOLEUR : # CAS DU VOLEUR
				if (current_health > max_health/2) : #PV>50%
					pass
				elif (current_health < max_health/4) : #PV<25%
					if (_fRand < 0.3) : #30%
						ChangeState(CharacterState.PEUR)
						return
				if (tab_pv_allie.size() == tab_pvmax_allie.size()) : #Seulement si les tableaux ont la même taille.
					for i in range (0, tab_pv_allie.size()) :
						_fRand = randf()
						if (tab_pv_allie[i] < (tab_pvmax_allie[i]/4) && _fRand < 0.2) : #Vérification de changement d'état par allié en dessous de 25%
							ChangeState(CharacterState.COLERE)
							return
				# Pas de vérification de la mana.
				match character_state :
					CharacterState.COLERE :
						pass
					CharacterState.PEUR :
						pass
					CharacterState.CONFIANCE :
						if (_fRand<0.1) : #10%
							ChangeState(CharacterState.ENNUI)
							return
						elif (_fRand<0.1+0.1): #10%
							ChangeState(CharacterState.NEUTRE)
							return
					CharacterState.ENNUI :
						pass
					_ :
						pass
	else :
		match _evenement :
			Evenement.ENNEMI_TUE : #Evènement ennemi tué
				match character_class :
					CharacterClass.GUERRIER || CharacterClass.MAGE : #Cas du guerrier ou du mage
						if (_fRand<0.5) :
							ChangeState(CharacterState.CONFIANCE)
					CharacterClass.VOLEUR : #Cas du voleur
						if (_fRand < 0.3) :
							ChangeState(CharacterState.COLERE)
						elif (_fRand < (0.3+0.5)) :
							ChangeState(CharacterState.CONFIANCE)
			_ : pass
		pass
	pass

func ChangeState (_character_state : CharacterState):
	character_state = _character_state
	temps_changement_etat = 0
	pass
