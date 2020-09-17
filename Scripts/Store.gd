extends Node2D

onready var item_unlocked = preload("res://Scenes/Prefabs/Store_Item_Unlocked.tscn")
onready var item_locked = preload("res://Scenes/Prefabs/Store_Item_Locked.tscn")

var posy = 65

func _ready():
	set_cookie()
	
	var store = Global.savedata["store"]
	for index in range(len(store)):
		add_item(index, store)

func add_item(index, store):
	if store[index]["unlock_level"]:
		var it_unlock = item_unlocked.instance()
		it_unlock.connect("buy", self, "set_cookie")
		it_unlock.set_item(store[index])
		it_unlock.set_position(Vector2(360, posy))
			
		get_node("Panel/ScrollContainer/VBoxContainer").add_child(it_unlock)
	else:
		var it_lock = item_locked.instance()
		it_lock.set_position(Vector2(360, posy))
		get_node("Panel/ScrollContainer/VBoxContainer").add_child(it_lock)
	posy += 140

func set_cookie():
	get_node("Control/Cookies").set_text(str(Global.savedata["cookie"]["amount"]))

func _on_Exit_pressed():
	Transition.clear_above()
