class_name PlayerBase
extends CharacterBody2D

@export var health: int
@export var maxHealth: int

@export var moveSpeed: int

# Called when the node enters the scene tree for the first time.
func _ready():
	health = clamp(health, 0, maxHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
