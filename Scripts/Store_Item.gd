extends Node2D

var obj

signal buy

func set_item(it):
	self.obj = it
	
	get_node("Control/Type").set_text(obj["name"])
	update()

func _on_TouchScreenButton_pressed():
	var price = get_node("Control/Price").get_text()
	if Global.buy(int(price), obj):
		update()
		emit_signal("buy")

func update():
	get_node("Control/Amount").set_text(str(obj["level"]))
	get_node("Control/Price").set_text("x " + str(
		calc_price(obj["level"], obj["gain"], obj["initial"])
	))
	
func calc_price(amount, gain, initial):
	if amount == 0:
		return initial
	else:
		return initial + (initial * gain) * amount
