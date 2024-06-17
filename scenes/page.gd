extends Area2D

@onready var level_1 = $"../.."
@onready var level_2 = $"../.."


func _on_body_entered(body):
	print("Responda a questão")
	level_1.quiz()
	level_1.enemies().paused = true
	queue_free()
