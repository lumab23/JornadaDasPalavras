extends Node

@onready var player = $Player
var index1 = 0
var index = 0  
@onready var quiz = $Quiz
var current_level = 1
var can_move = true

var coins := 0
var score := 0
var player_life := 3

func _ready():
	# Adjust the path as necessary to find the player node
	player = get_node("Player")  

func iniciar():
	can_move = true

func pausar():
	can_move = false
