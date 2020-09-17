extends Node2D

onready var gen = get_node("Generate")
onready var Small_Cookie = preload("res://Scenes/Prefabs/Small_Cookie.tscn")

var gain = null
var cookie = null
var speed = 0

signal click_enable
signal click_disable

func _ready():
	get_node("Generate/Timer").set_wait_time(Global.savedata["cookie"]["time_of_generate"])
	randomize()
	set_process(true)
	
func _process(delta):
	var big_cookie = Global.savedata["cookie"]
	get_node("HUD/Control/Cookies").set_text(str(big_cookie["amount"]))
	get_node("HUD/Control/perSecond").set_text(str(big_cookie["per_second"]) + " / per second")
	
	if cookie:
		if cookie.get_position().y > 1350:
			reset_cookie_small()
		else:
			cookie.set_position(Vector2(cookie.get_position().x, cookie.get_position().y + speed))

func _on_Timer_timeout():	
	var rand = int(rand_range(0, 100))
	if rand <= Global.savedata["cookie"]["chance_gold"]:
		gen_cookie_small("gold")
	elif rand <= Global.savedata["cookie"]["chance_normal"]:
		gen_cookie_small("normal")

func gen_cookie_small(tex):
	if cookie == null:
		cookie = Small_Cookie.instance()
		cookie.set_position(Vector2(int(rand_range(50, 660)), 0))
		cookie.change_texture(tex)
		gen.add_child(cookie)
	
		speed = 10
		get_node("Generate/Timer").stop()
		cookie.connect("small_cookie", self, "get_cookie")
		
func reset_cookie_small():
	#gen.remove_child(cookie)
	cookie.queue_free()
	cookie = null
	emit_signal("click_enable")
	
	#gen.remove_child(cookie)
	#cookie = null
	get_node("Generate/Timer").start()
		
func get_cookie():
	get_node("Cookie").click = cookie.click
	Global.cookie_gain(cookie.calc_gain())
	#cookie.disable()
	emit_signal("click_disable")
	
	speed = 0
	cookie.hide()
	yield(get_tree().create_timer(.3), "timeout")
	
	reset_cookie_small()

func _on_Store_pressed():
	if get_tree().paused:
		return
	Transition.put_above("res://Scenes/Store.tscn")

func _on_Task_pressed():
	if get_tree().paused:
		return
	Transition.put_above("res://Scenes/Task.tscn")
