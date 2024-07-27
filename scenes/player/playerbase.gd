class_name PlayerBase
extends CharacterBody2D

@export var health: int
@export var maxHealth: int

@export var moveSpeed: int
var running: bool = false

@onready var sprite: AnimatedSprite2D = $redsprite
@onready var animtree: AnimationTree = $AnimationTree
# Called when the node enters the scene tree for the first time.
func _ready():
	health = clamp(health, 0, maxHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	handleInputs()
	handleAnimations()
	
	velocity *= moveSpeed
	move_and_slide()

func handleInputs():
	if Input.is_action_pressed("move_up"):
		velocity.y += 1.0
	if Input.is_action_pressed("move_down"):
		velocity.y += -1.0
	if Input.is_action_pressed("move_left"):
		velocity.x += -1.0
		sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		velocity.x += 1.0
		sprite.flip_h = false
	
	if Input.is_action_pressed("sprint"):
		running = true
	else:
		running = false
	
	velocity = velocity.normalized()

func handleAnimations():
	if velocity == Vector2.ZERO:
		animtree ["paramaters/conditions/idle"] = true
		animtree ["paramaters/conditions/walk"] = false
		animtree ["paramaters/conditions/run"] = false
	elif !running:
		animtree.set("parameters/Idle/blend_position", velocity)
		animtree.set("paramaters/Walk/blend_position", velocity)
	else:
		animtree.get("paramaters/playback").travel("Run")
		animtree.set("parameters/Idle/blend_position", velocity)
		animtree.set("paramaters/Walk/blend_position", velocity)
		animtree.set("paramaters/Run/blend_position", velocity)
