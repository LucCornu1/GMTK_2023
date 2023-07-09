extends Character

class_name Mage

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	character_class = CharacterClass.MAGE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func begin_turn():
	super.begin_turn()
	return ChoseAction()

func do_action( _characterlist,action: CharacterAction = CharacterAction.ATTENDRE):
	character_list = _characterlist
	match action:
		CharacterAction.ACTION1:
			if (lose_mana(10)) :
				bouledefeu()
			else :
				attendre()
		CharacterAction.ACTION2:
			if (lose_mana(5)) :
				soin()
			else :
				attendre()
		CharacterAction.ACTION3:
			coupsceptre()
		CharacterAction.ATTENDRE:
			print("Idle")
			attendre()
	# print(self)
	animation_player_node.play("AttackAnimation")

func _get_action1_name():
	return "A1"

func _get_action2_name():
	return "A2"

func _get_action3_name():
	return "A3"

func bouledefeu():
	var cible = CibleEnnemiUnique()
	if (cible!=self):
		cible.damage(80)

func attendre():
	_set_mana(current_mana+15)

func soin():
	var cible = CibleEnnemiUnique()
	cible.heal(100)

func coupsceptre():
	var cible = CibleEnnemiUnique()
	if (cible!=self):
		cible.damage(20)

func _get_actionname() -> String:
	match character_action:
		CharacterAction.ACTION1 :
			return "Boule de Feu"
		CharacterAction.ACTION2 :
			return "Soin"
		CharacterAction.ACTION3 :
			return "Coup de Sceptre"
		CharacterAction.ATTENDRE :
			return "Attendre"
		_ :
			return ""
