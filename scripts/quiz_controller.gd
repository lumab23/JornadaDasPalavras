extends Node

@export var quiz : QuizPortugues
@export var color_right: Color
@export var color_wrong: Color

var buttons : Array[Button]
#var index : int
var correct: int

var current_quiz: QuizQuestion:
	get: return quiz.questions[Global.index]

#@onready var question_text = $content/Panel/backgroundQuestion/QuestionText
#@onready var background_question = $content/Panel/backgroundQuestion
@onready var question_text = $Content/MarginContainer/MarginContainer/Panel/QuestionText



func _ready():
	for button in $Content/MarginContainer2/PanelButtons.get_children():
		buttons.append(button)
	load_quiz()



func load_quiz():
	if Global.index1 >= quiz.questions.size():
		return
		

	question_text.text = current_quiz.question_info
	var options = current_quiz.options
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))
		
		

func _buttons_answer(button):
	if current_quiz.correct == button.text:
		button.modulate = color_right
		Global.index += 1
		await get_tree().create_timer(1).timeout
		queue_free()
	else:
		button.modulate = color_wrong
		Global.player_life -= 1
		await get_tree().create_timer(1).timeout
		queue_free()
		

	_next_question()


func _next_question():
	for bt in buttons:
		bt.pressed.disconnect(_buttons_answer)
	
	await get_tree().create_timer(0.7).timeout
	
	for bt in buttons:
		bt.modulate = Color.WHITE
	
	Global.index1 += 1
	load_quiz()


