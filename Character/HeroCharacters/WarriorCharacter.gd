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

func do_action( _characterlist,action: CharacterAction = character_action):
	character_list = _characterlist
	match action:
		CharacterAction.ACTION1:
			coupdepee()
		CharacterAction.ACTION2:
			attaquetournoyante()
		CharacterAction.ACTION3:
			sedefendre()
		CharacterAction.ATTENDRE:
			print("Idle")
			attendre()
	animation_player_node.play("AttackAnimation")

func coupdepee():
	var cible = CibleEnnemiUnique()
	if (cible!=self):
		cible.damage(60)

func attendre():
	pass

func attaquetournoyante():
	var cibles = CibleToutEnnemi()
	if (cibles.size()>0) :
		for cible in cibles :
			cible.damage(30)

func sedefendre():
	bDefense = true

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
