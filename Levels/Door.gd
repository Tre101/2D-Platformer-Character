extends Area2D


func _ready():
	pass

func _on_Door_body_entered(body):
	if Global.save_data["level"] == 1:
		Global.save_data["level"] = 2
	if body.name == "Player":
		get_tree().change_scene("res://Levels/Level2.tscn")
