extends Control

class_name CombatUI


@export var top_character: Character
@export var middle_character: Character
@export var bottom_character: Character

@onready var character_state_node: CharacterStateUI = get_node("BottomLeft/CharacterState")
@onready var character_state2_node: CharacterStateUI = get_node("BottomLeft/CharacterState2")
@onready var character_state3_node: CharacterStateUI = get_node("BottomLeft/CharacterState3")


# Called when the node enters the scene tree for the first time.
func _ready():
	character_state_node.init(top_character)
	character_state2_node.init(middle_character)
	character_state3_node.init(bottom_character)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
