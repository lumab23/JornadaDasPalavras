extends Area2D

@onready var level_1 = $"../.."
@onready var level_2 = $"../.."
@onready var level_3 = $"../.."

@onready var slime = $"../../enemies/Slime"

func _on_body_entered(body):
	print("Responda a questão")
	if Global.current_level == 1: 
		level_1.quiz()
		#slime.iniciar()
	if Global.current_level == 2: 
		level_2.quiz()
	if Global.current_level == 3:
		level_3.quiz()
	queue_free()
