extends Area2D

var coins := 1
@onready var coin_coleted = $coinColeted

func _on_body_entered(body):
	coin_coleted.play()
	await $colision.call_deferred("queue_free")
	Global.coins += coins
	print(Global.coins)
	queue_free()
