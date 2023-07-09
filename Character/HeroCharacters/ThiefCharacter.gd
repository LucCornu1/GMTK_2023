extends Character

class_name Thief

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	character_class = CharacterClass.VOLEUR

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func begin_turn():
	super.begin_turn()
	return ChoseAction()

func do_action( _characterlist,action: CharacterAction = character_action):
	character_list = _characterlist
	
	var anim_name: String = "Default"
	match action:
		CharacterAction.ACTION1:
			coupdedague()
			anim_name = "Attack"
		CharacterAction.ACTION2:
			empoisonnement()
			anim_name = "PoisonAttack"
		CharacterAction.ACTION3:
			cacher()
			anim_name = "Hide"
		CharacterAction.ATTENDRE:
			print("Idle")
			attendre()

	animation_player_node.play(anim_name)


func coupdedague():
	var cible = CibleEnnemiUnique()
	if (cible!=self):
		cible.damage(40)

func attendre():
	pass

func empoisonnement():
	var cible = CibleEnnemiUnique()
	if (cible!=self):
		cible.damage(30)
		cible.empoisonnement()

func cacher():
	bCache = true

func _get_actionname() -> String: 
	match character_action:
		CharacterAction.ACTION1 :
			return "Coup de Dague"
		CharacterAction.ACTION2 :
			return "Empoisonnement"
		CharacterAction.ACTION3 :
			return "Se cacher"
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
