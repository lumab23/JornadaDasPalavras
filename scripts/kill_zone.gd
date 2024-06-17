extends Area2D

@onready var timer = $Timer
@onready var start_delay_timer = $start_delay_timer

func _ready():
	start_delay_timer.start()  # Start the initial delay timer

func _on_start_delay_timer_timeout():
	start_delay_timer.stop()  # Garantir que o timer de atraso inicial seja parado
	
func _on_body_entered(body):
	if start_delay_timer.is_stopped():  # Only trigger if the initial delay has passed
		print("You died! Collided with: %s" % body.name)
		body.lose_life()
		body.play_hurt_animation()
		Global.score = 0
		Global.coins = 0
		Global.player_life = 0
		body._game_over()

func _on_timer_timeout():
	get_tree().reload_current_scene()
