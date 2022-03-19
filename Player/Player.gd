extends KinematicBody2D

onready var SM = $StateMachine

var velocity = Vector2.ZERO
var jump_power = Vector2.ZERO
var direction = 1

export var gravity = Vector2(0,30)

export var move_speed = 20
export var max_move = 300

export var jump_speed = 100
export var max_jump = 1000

export var leap_speed = 100
export var max_leap = 1000

var moving = false
var is_jumping = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite
var animating = false

export var light_punch = 10
export var med_punch = 20
export var heavy_punch = 30

export var light_kick = 15
export var med_kick = 25
export var heavy_kick = 40

var Enemy = null

var moves = []

func _physics_process(_delta):
	velocity.x = clamp(velocity.x,-max_move,max_move)
	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = true
		if direction > 0 and $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = false

func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1

func set_animation(anim):
	animating = true
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func is_on_floor():
	var fl = $Floor.get_children()
	for f in fl:
		if f.is_colliding():
			return true
	return false

func die():
	queue_free()


func _on_AnimatedSprite_animation_finished():
	animating = false
