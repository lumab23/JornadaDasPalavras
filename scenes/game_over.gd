extends CanvasLayer

var current_level_restart = Global.current_level
@onready var music = $music

func _ready():
	music.play()

func _on_button_pressed():
	Global.player_life = 3
	if Global.current_level == 1:
		Global.index = 0
	elif Global.current_level == 2:
		Global.index = 3
	else: 
		Global.index = 6
	
	get_tree().reload_current_scene()
	
