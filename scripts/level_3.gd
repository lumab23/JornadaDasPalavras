extends Node2D
var quiz_scene = load("res://scenes/quiz.tscn")

func quiz():
	var quiz = quiz_scene.instantiate()
	
	add_child(quiz)
