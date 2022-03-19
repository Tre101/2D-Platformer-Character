extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Punching")
	if Input.is_action_pressed("light_punch"):
		player.moves.append("light_punch")
	if Input.is_action_pressed("med_punch"):
		player.moves.append("med_punch")
	if Input.is_action_pressed("heavy_punch"):
		player.moves.append("heavy_punch")
	if player.moves == ["light_punch", "med_punch", "heavy_punch"]:
		print("special move")
	player.moves = []

func physics_process(_delta):
	if not player.animating:
		var punch = player.get_node("Attack/Punch")
		if punch.is_colliding():
			var enemy = punch.get_collider()
			if enemy.has_method("damage"):
				enemy.damage(player.light_punch)
		SM.set_state("Idle")
