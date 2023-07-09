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

func do_action( _characterlist,action: CharacterAction = CharacterAction.ATTENDRE):
	character_list = _characterlist
	match action:
		CharacterAction.ACTION1:
			coupdedague()
		CharacterAction.ACTION2:
			empoisonnement()
		CharacterAction.ACTION3:
			cacher()
		CharacterAction.ATTENDRE:
			attendre()
	#animation_player_node.play("AttackAnimation")

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
