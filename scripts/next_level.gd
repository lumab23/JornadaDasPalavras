extends Area2D

const FILE_BEGIN = "res://scenes/level_"
var win_scene = load("res://scenes/win.tscn")
var limite_questao;
@onready var up_nivel = $up_nivel
@onready var player = $"."

func _ready():
	limite_questao = Global.index + 1

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if Global.current_level == 3:
			var win = win_scene.instantiate()
			add_child(win)
		elif Global.index >= limite_questao :
			up_nivel.play()
			Global.current_level += 1
			player.queue_free()
			var current_scene_file = get_tree().current_scene.scene_file_path
			var next_level_number = current_scene_file.to_int() + 1
			var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
			get_tree().change_scene_to_file(next_level_path)
	 
	

