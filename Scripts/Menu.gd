extends Node2D

onready var gen = get_node("Generate")
onready var Small_Cookie = preload("res://Scenes/Prefabs/Small_Cookie.tscn")

var cookie = []
var speed = 0

func _ready():
	randomize()
	set_process(true)

func _process(delta):
	for i in range(cookie.size()):
		if cookie[i].get_position().y > 1300:
			gen.remove_child(cookie[i])
			cookie.erase(cookie[i])
			break
		else:
			cookie[i].set_position(Vector2(cookie[i].get_position().x, cookie[i].get_position().y + speed))

func gen_cookie_small():
	var ran = rand_range(1, 3)
	var ck = Small_Cookie.instance()
	ck.set_scale(Vector2(ran, ran))
	ck.set_position(Vector2(int(rand_range(50, 660)), 0))
	ck.change_texture("normal")
	cookie.append(ck)
	gen.add_child(ck)

	speed = 10

func _on_Timer_timeout():
	gen_cookie_small()

func _on_TouchScreenButton_pressed():
	Transition.fade_to("res://Scenes/Game.tscn")
