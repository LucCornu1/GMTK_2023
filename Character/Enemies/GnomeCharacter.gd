extends Character

class_name Gnome

var target: Character
var is_hidden: bool = false

@onready var anim_node: AnimatedSprite2D = get_node("AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	character_class = CharacterClass.GNOME

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func begin_turn():
	super.begin_turn()
	is_hidden = false

func _set_health(value: float):
	if not is_hidden:
		super._set_health(value)

func do_action(_characterlist, action: CharacterAction = CharacterAction.ATTENDRE):
	character_list = _characterlist
	target = CibleEnnemiUnique()
	
	var anim_name: String = "Default"
	match action:
		CharacterAction.ACTION1:
			target._set_health(target._get_health() - 30)
			anim_name = "Attack"
		CharacterAction.ACTION2:
			var _fRand : float = randf()
			if _fRand < 0.5:
				target.ChangeState(CharacterState.COLERE)
			anim_name = "Laugh"
		CharacterAction.ACTION3:
			is_hidden = true
			anim_name = "Hide"
	
	animation_player_node.play(anim_name)


func _get_action1_name():
	return "Attack"

func _get_action2_name():
	return "Laugh"

func _get_action3_name():
	return "Hide"
