extends Node2D

@onready var enemies = $enemies/Slime

var quiz_scene = load("res://scenes/quiz.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func quiz():
	var quiz = quiz_scene.instantiate()
	
	add_child(quiz)
