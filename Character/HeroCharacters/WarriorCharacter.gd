extends Character

class_name Warrior

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	character_class = CharacterClass.GUERRIER

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
			coupdepee()
		CharacterAction.ACTION2:
			attaquetournoyante()
		CharacterAction.ACTION3:
			sedefendre()
		CharacterAction.ATTENDRE:
			attendre()
	#animation_player_node.play("AttackAnimation")

func coupdepee():
	pass

func attendre():
	pass

func attaquetournoyante():
	pass

func sedefendre():
	pass

func _get_actionname() -> String: 
	match character_action:
		CharacterAction.ACTION1 :
			return "Coup d'épée"
		CharacterAction.ACTION2 :
			return "Attaque tournoyante"
		CharacterAction.ACTION3 :
			return "Se défendre"
		CharacterAction.ATTENDRE :
			return "Attendre"
		_ :
			return ""
