extends Control

class_name CombatUI


@export var top_character: Character
@export var middle_character: Character
@export var bottom_character: Character

@export var enemy_0: Character
@export var enemy_1: Character
@export var enemy_2: Character
@export var enemy_3: Character

@onready var character_state_node: CharacterStateUI = get_node("BottomLeft/CharacterState")
@onready var character_state2_node: CharacterStateUI = get_node("BottomLeft/CharacterState2")
@onready var character_state3_node: CharacterStateUI = get_node("BottomLeft/CharacterState3")

@onready var enemy_state_node: CharacterStateUI = get_node("BottomRight/EnemyState")
@onready var enemy_state2_node: CharacterStateUI = get_node("BottomRight/EnemyState2")
@onready var enemy_state3_node: CharacterStateUI = get_node("BottomRight/EnemyState3")
@onready var enemy_state4_node: CharacterStateUI = get_node("BottomRight/EnemyState4")


# Called when the node enters the scene tree for the first time.
func _ready():
	character_state_node.init(top_character)
	character_state2_node.init(middle_character)
	character_state3_node.init(bottom_character)
	
	enemy_state_node.init(enemy_0)
	enemy_state2_node.init(enemy_1)
	enemy_state3_node.init(enemy_2)
	enemy_state4_node.init(enemy_3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
