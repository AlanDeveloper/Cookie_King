extends Node2D

var bonus = 1
var click = false

signal small_cookie

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.is_pressed() and !click:
		click = true
		#get_node("Area2D/CollisionShape2D").disabled
		emit_signal("small_cookie")

func change_texture(tex):
	if tex == "normal":
		bonus = 1
		get_node("Area2D/Sprite").set_texture(load("res://Assets/Cookie Normal.png"))
	else:
		bonus = 2
		get_node("Area2D/Sprite").set_texture(load("res://Assets/Cookie Gold.png"))

func hide():
	get_node("AnimationPlayer").play("Hide")
	
func calc_gain():
	var gain = 0
	var per_second = Global.savedata["cookie"]["per_second"]
	if per_second == 0:
		gain += 20 * bonus
	else:
		gain += per_second * 110 * bonus
	get_node("Control/Label").set_text("+" + str(gain))
	return gain

func disable():
	get_node("Area2D/CollisionShape2D").disabled = true
