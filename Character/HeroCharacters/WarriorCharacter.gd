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
	
	var anim_name: String = "Default"
	match action:
		CharacterAction.ACTION1:
			coupdepee()
			anim_name = "Attack"
		CharacterAction.ACTION2:
			attaquetournoyante()
			anim_name = "Attack"
		CharacterAction.ACTION3:
			sedefendre()
			anim_name = "Block"
		CharacterAction.ATTENDRE:
			attendre()
	
	animation_player_node.play(anim_name)

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


func _get_action1_name():
	return "Attack"

func _get_action2_name():
	return "Laugh"

func _get_action3_name():
	return "Hide"
