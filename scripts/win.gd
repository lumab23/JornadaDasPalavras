extends CanvasLayer
@onready var music = $music

func _ready():
	music.play()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
