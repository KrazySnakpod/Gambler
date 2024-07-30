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
	
	if Input.is_action_just_pressed("sprint"):
		running = true
		moveSpeed *= 1.5
	
	if Input.is_action_just_released("sprint"):
		running = false
		moveSpeed /= 1.5
	
	
	velocity = velocity.normalized()

func handleAnimations():
	if velocity == Vector2.ZERO:
		animtree["parameters/conditions/idle"] = true;
		animtree["parameters/conditions/is_moving"] = false;
		animtree["parameters/conditions/is_running"] = false;
		
	elif running:
		animtree["parameters/conditions/idle"] = false;
		animtree["parameters/conditions/is_moving"] = false;
		animtree["parameters/conditions/is_running"] = true;
		
		animtree["parameters/Idle/blend_position"] = velocity
	else:
		animtree["parameters/conditions/idle"] = false;
		animtree["parameters/conditions/is_moving"] = true;
		animtree["parameters/conditions/is_running"] = false;
		
		animtree["parameters/Idle/blend_position"] = velocity
	
	if Input.is_action_just_pressed("roll"):
		animtree["parameters/conditions/roll"] = true
	
	animtree["parameters/Walk/blend_position"] = velocity
	animtree["parameters/Run/blend_position"] = velocity
	animtree["parameters/Roll/blend_position"] = velocity
