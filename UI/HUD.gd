extends CanvasLayer

var countdown = 60

func _ready():
	$Panel/Player1.value = Global.player1_health
	update_score()

func _physics_process(delta):
	$Panel/Player1.value = Global.player1_health

func update_score():
	$Panel/Score.text = "Score " + str(Global.save_data["score"])

func _on_Timer_timeout():
	countdown -= 1
	$Panel/Time.text = str(countdown)
	if countdown <= 0:
		get_tree().change_scene("res://Levels/Level2.tscn")
	
