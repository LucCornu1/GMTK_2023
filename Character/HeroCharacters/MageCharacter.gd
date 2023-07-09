extends Character

class_name Mage

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func begin_turn():
	super.begin_turn()
	return ChoseAction()

func do_action(action: CharacterAction = CharacterAction.ATTENDRE):
	match action:
		CharacterAction.ACTION1:
			print("Action1")
		CharacterAction.ACTION2:
			print("Action2")
		CharacterAction.ACTION3:
			print("Action3")
		CharacterAction.ATTENDRE:
			print("Idle")
	
	animation_player_node.play("AttackAnimation")
