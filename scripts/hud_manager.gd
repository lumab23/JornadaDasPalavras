extends Control

@onready var coins_count = $container/coins_container/coins_count as Label
@onready var score_counter = $container/score_container/score_counter as Label
@onready var life_counter = $container/life_container/life_counter as Label

func _ready():
	coins_count.text = str("%04d" % Global.coins)
	score_counter.text = str("%06d" % Global.score)
	life_counter.text = str("%02d" % Global.player_life)


func _process(delta):
	coins_count.text = str("%04d" % Global.coins)
	score_counter.text = str("%06d" % Global.score)
	life_counter.text = str("%02d" % Global.player_life)
