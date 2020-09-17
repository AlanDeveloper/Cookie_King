extends Node2D

var click = false
var mouse = 1

func _on_Area2D_input_event(viewport, event, shape_idx):
	print(event)
	if event is InputEventScreenTouch and event.is_pressed():
		var gain = get_node("Control")
		var position = event.get_position()
		gain.set_position(Vector2(position.x - 360, position.y - 640))
		
		var animation = get_node("AnimationPlayer")
		animation.stop()
		animation.play("Touch")
		
		Global.cookie_click()
	
func _on_Timer_timeout():
	Global.cookie_gain(Global.savedata["cookie"]["per_second"])

func _on_Game_click_enable():
	pass

func _on_Game_click_disable():
	pass
